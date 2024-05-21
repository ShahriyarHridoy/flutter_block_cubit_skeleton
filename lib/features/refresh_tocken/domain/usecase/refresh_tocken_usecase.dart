import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/model/refresh_tocken_request.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/model/refresh_tocken_response.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/domain/repository/refresh_tocken_repository.dart';

class RefreshTokenUsecase {
  final RefreshTokenRepository _refreshTokenRepository;

  RefreshTokenUsecase(this._refreshTokenRepository);

  Future<RefreshTokenResponse> call(RefreshTokenRequest refreshTokenRequest) =>
      _refreshTokenRepository.refreshToken(refreshTokenRequest);
}
