import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/network/connection_checker.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_response.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/remote/check_otp_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/domain/repository/check_otp_repository.dart';

class CheckOtpRepositoryImpl implements CheckOtpRepository {
  final ConnectionChecker _connectionChecker;
  final CheckOtpRemote checkOtpRemote;

  // final TokenSource tokenSource;

  CheckOtpRepositoryImpl(
    this._connectionChecker,
    this.checkOtpRemote,
  );

  @override
  Future<CheckOtpResponse> checkOtp(CheckOtpRequest checkOtpRequest) async {
    if (!await _connectionChecker.isConnected()) throw NoInternetException();
    CheckOtpResponse checkOtpResponse =
        await checkOtpRemote.checkOtp(checkOtpRequest);
    // await tokenSource.saveToken(checkOtpResponse.accessToken!);

    return checkOtpResponse;
  }
}
