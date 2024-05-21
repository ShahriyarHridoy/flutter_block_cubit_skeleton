import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_response.dart';

abstract class CheckOtpRepository {
  Future<CheckOtpResponse> checkOtp(CheckOtpRequest checkOtpRequest);
}
