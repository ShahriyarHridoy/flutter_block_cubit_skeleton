import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/network/connection_checker.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/model/send_otp_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/model/send_otp_response.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/remote/send_otp_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/domain/repository/send_otp_repository.dart';

class SendOtpRepositoryImpl implements SendOtpRepository {
  final ConnectionChecker _connectionChecker;
  final SendOtpRemote sendOtpRemote;

  // final TokenSource tokenSource;

  SendOtpRepositoryImpl(
    this._connectionChecker,
    this.sendOtpRemote,
  );

  @override
  Future<SendOtpResponse> sendOtp(SendOtpRequest sendOtpRequest) async {
    if (!await _connectionChecker.isConnected()) throw NoInternetException();
    SendOtpResponse sendOtpResponse =
        await sendOtpRemote.sendOtp(sendOtpRequest);
    // await tokenSource.saveToken(sendOtpResponse.accessToken!);

    return sendOtpResponse;
  }
}
