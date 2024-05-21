import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_response.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/domain/usecase/check_otp_usecase.dart';

part 'check_otp_state.dart';

class CheckOtpCubit extends Cubit<CheckOtpState> {
  final CheckOtpUsecase checkOtpUsecase;

  CheckOtpCubit({required this.checkOtpUsecase}) : super(CheckOtpInitial());

  Future<void> checkOtp(CheckOtpRequest checkOtpRequest) async {
    try {
      emit(CheckOtpLoading());
      final responseModel = await checkOtpUsecase(checkOtpRequest);
      emit(CheckOtpSuccess(model: responseModel));
    } catch (ex, strackTrace) {
      emit(CheckOtpFailure(ex, strackTrace));
    }
  }
}
