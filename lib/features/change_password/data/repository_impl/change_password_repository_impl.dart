import 'package:flutter_block_cubit_skeleton/common/data/data_source/local/token_source.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/network/connection_checker.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/data/model/change_password_request.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/data/model/change_password_response.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/data/remote/change_password_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/domain/repository/change_password_repository.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ConnectionChecker _connectionChecker;
  final ChangePasswordRemote changePasswordRemote;
  final TokenSource tokenSource;

  ChangePasswordRepositoryImpl(
      this._connectionChecker, this.changePasswordRemote, this.tokenSource);

  @override
  Future<ChangePasswordResponse> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    if (!await _connectionChecker.isConnected()) throw NoInternetException();
    ChangePasswordResponse changePasswordResponse =
        await changePasswordRemote.changePassword(changePasswordRequest);
    // await tokenSource.saveToken(changePasswordResponse.accessToken!);

    return changePasswordResponse;
  }
}
