import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/model/refresh_tocken_request.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/model/refresh_tocken_response.dart';

abstract class RefreshTokenRepository {
  Future<RefreshTokenResponse> refreshToken(
      RefreshTokenRequest refreshTokenRequest);
}
