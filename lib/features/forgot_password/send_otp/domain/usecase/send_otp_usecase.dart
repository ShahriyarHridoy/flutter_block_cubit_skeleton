import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/model/send_otp_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/model/send_otp_response.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/domain/repository/send_otp_repository.dart';

class SendOtpUsecase {
  final SendOtpRepository _sendOtpRepository;

  SendOtpUsecase(this._sendOtpRepository);

  Future<SendOtpResponse> call(SendOtpRequest sendOtpRequest) =>
      _sendOtpRepository.sendOtp(sendOtpRequest);
}
