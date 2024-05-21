import 'package:flutter_block_cubit_skeleton/common/data/data_source/local/token_source.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/network/connection_checker.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/model/refresh_tocken_request.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/model/refresh_tocken_response.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/remote/refresh_tocken_remote.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/domain/repository/refresh_tocken_repository.dart';

class RefreshTokenRepositoryImpl implements RefreshTokenRepository {
  final ConnectionChecker _connectionChecker;
  final RefreshTokenRemote refreshTokenRemote;
  final TokenSource tokenSource;

  RefreshTokenRepositoryImpl(
      this._connectionChecker, this.refreshTokenRemote, this.tokenSource);

  @override
  Future<RefreshTokenResponse> refreshToken(
      RefreshTokenRequest refreshTokenRequest) async {
    if (!await _connectionChecker.isConnected()) throw NoInternetException();
    RefreshTokenResponse refreshTokenResponse =
        await refreshTokenRemote.refreshToken(refreshTokenRequest);
    await tokenSource.saveToken(refreshTokenResponse.data!.accessToken!);
    await tokenSource
        .saveRefreshToken(refreshTokenResponse.data!.refreshToken!);

    return refreshTokenResponse;
  }
}
