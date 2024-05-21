import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_response.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/domain/repository/check_otp_repository.dart';

class CheckOtpUsecase {
  final CheckOtpRepository _checkOtpRepository;

  CheckOtpUsecase(this._checkOtpRepository);

  Future<CheckOtpResponse> call(CheckOtpRequest checkOtpRequest) =>
      _checkOtpRepository.checkOtp(checkOtpRequest);
}
