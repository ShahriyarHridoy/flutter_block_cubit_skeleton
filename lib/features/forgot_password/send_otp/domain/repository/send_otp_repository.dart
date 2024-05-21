import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/model/send_otp_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/model/send_otp_response.dart';

abstract class SendOtpRepository {
  Future<SendOtpResponse> sendOtp(SendOtpRequest sendOtpRequest);
}
