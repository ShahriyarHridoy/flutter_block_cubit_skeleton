import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_response.dart';

import '../../data/model/otp_validate_request.dart';

abstract class OtpValidateRepository {
  Future<CheckOtpResponse> otpValidate(OtpValidateRequest otpValidateRequest);
}
