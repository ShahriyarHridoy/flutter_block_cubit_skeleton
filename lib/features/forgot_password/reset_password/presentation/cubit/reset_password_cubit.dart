import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/data/model/reset_password_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/data/model/reset_password_response.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/domain/usecase/reset_password_usecase.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUsecase resetPasswordUsecase;

  ResetPasswordCubit({required this.resetPasswordUsecase})
      : super(ResetPasswordInitial());

  Future<void> resetPassword(ResetPasswordRequest resetPasswordRequest) async {
    try {
      emit(ResetPasswordLoading());
      final responseModel = await resetPasswordUsecase(resetPasswordRequest);
      emit(ResetPasswordSuccess(model: responseModel));
    } catch (ex, strackTrace) {
      emit(ResetPasswordFailure(ex, strackTrace));
    }
  }
}
