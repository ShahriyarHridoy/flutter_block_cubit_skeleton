import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/network/connection_checker.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/data/model/reset_password_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/data/model/reset_password_response.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/data/remote/reset_password_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/domain/repository/reset_password_repository.dart';

class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ConnectionChecker _connectionChecker;
  final ResetPasswordRemote resetPasswordRemote;

  // final TokenSource tokenSource;

  ResetPasswordRepositoryImpl(
    this._connectionChecker,
    this.resetPasswordRemote,
  );

  @override
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    if (!await _connectionChecker.isConnected()) throw NoInternetException();
    ResetPasswordResponse resetPasswordResponse =
        await resetPasswordRemote.resetPassword(resetPasswordRequest);
    // await tokenSource.saveToken(resetPasswordResponse.accessToken!);

    return resetPasswordResponse;
  }
}
