import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/data/model/change_password_request.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/data/model/change_password_response.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/domain/usecase/change_password_usecase.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUsecase changePasswordUsecase;

  ChangePasswordCubit({required this.changePasswordUsecase})
      : super(ChangePasswordInitial());

  Future<void> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    try {
      emit(ChangePasswordLoading());
      final responseModel = await changePasswordUsecase(changePasswordRequest);
      emit(ChangePasswordSuccess(model: responseModel));
    } catch (ex, strackTrace) {
      emit(ChangePasswordFailure(ex, strackTrace));
    }
  }
}
