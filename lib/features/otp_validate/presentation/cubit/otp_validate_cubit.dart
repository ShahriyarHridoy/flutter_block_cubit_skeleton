import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_response.dart';

import '../../data/model/otp_validate_request.dart';
import '../../domain/usecase/otp_validate_usecase.dart';

part 'otp_validate_state.dart';

class OtpValidateCubit extends Cubit<OtpValidateState> {
  final OtpValidateUsecase otpValidateUsecase;

  OtpValidateCubit({required this.otpValidateUsecase})
      : super(OtpValidateInitial());

  Future<void> otpValidate(OtpValidateRequest otpValidateRequest) async {
    try {
      emit(OtpValidateLoading());
      final responseModel = await otpValidateUsecase(otpValidateRequest);
      emit(OtpValidateSuccess(model: responseModel));
    } catch (ex, strackTrace) {
      emit(OtpValidateFailure(ex, strackTrace));
    }
  }
}
