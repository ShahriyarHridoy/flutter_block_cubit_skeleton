import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenSource {
  static const kAccessTokenKey = "accessToken";
  static const kRefreshTokenKey = "refreshToken";
  Future<bool> saveToken(String token);
  Future<bool> saveRefreshToken(String refreshToken);
  String getToken();
  String getRefreshToken();
}

class TokenSourceImpl implements TokenSource {
  final SharedPreferences _preference;

  TokenSourceImpl(this._preference);
  @override
  String getToken() {
    log("${_preference.getString(TokenSource.kAccessTokenKey)}");

    return _preference.getString(TokenSource.kAccessTokenKey) ?? "NO_TOKEN";
  }
  
   @override
  String getRefreshToken() {
    log("${_preference.getString(TokenSource.kRefreshTokenKey)}");

    return _preference.getString(TokenSource.kRefreshTokenKey) ?? "NO_REFRESH_TOKEN";
  }

  @override
  Future<bool> saveToken(String token) {
    return _preference.setString(TokenSource.kAccessTokenKey, token);
  }

  @override
  Future<bool> saveRefreshToken(String refreshToken) {
    return _preference.setString(TokenSource.kRefreshTokenKey, refreshToken);
  }
}
