import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_response.dart';

import '../../data/model/otp_validate_request.dart';
import '../repository/otp_validate_repository.dart';

class OtpValidateUsecase {
  final OtpValidateRepository _otpValidateRepository;

  OtpValidateUsecase(this._otpValidateRepository);

  Future<CheckOtpResponse> call(OtpValidateRequest otpValidateRequest) =>
      _otpValidateRepository.otpValidate(otpValidateRequest);
}
