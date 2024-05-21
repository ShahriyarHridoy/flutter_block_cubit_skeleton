import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/network/connection_checker.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_response.dart';

import '../../domain/repository/otp_validate_repository.dart';
import '../model/otp_validate_request.dart';
import '../remote/otp_validate_remote.dart';

class OtpValidateRepositoryImpl implements OtpValidateRepository {
  final ConnectionChecker _connectionChecker;
  final OtpValidateRemote otpValidateRemote;

  // final TokenSource tokenSource;

  OtpValidateRepositoryImpl(
    this._connectionChecker,
    this.otpValidateRemote,
  );

  @override
  Future<CheckOtpResponse> otpValidate(
      OtpValidateRequest otpValidateRequest) async {
    if (!await _connectionChecker.isConnected()) throw NoInternetException();
    CheckOtpResponse checkOtpResponse =
        await otpValidateRemote.otpValidate(otpValidateRequest);
    // await tokenSource.saveToken(checkOtpResponse.accessToken!);

    return checkOtpResponse;
  }
}
