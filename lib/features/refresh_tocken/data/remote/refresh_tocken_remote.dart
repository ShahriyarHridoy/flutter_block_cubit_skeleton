import 'dart:convert';
import 'dart:developer';

import 'package:flutter_block_cubit_skeleton/core/constant/api_constants.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/header_provider/header_provider.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/model/refresh_tocken_request.dart';
import 'package:flutter_block_cubit_skeleton/features/refresh_tocken/data/model/refresh_tocken_response.dart';
import 'package:http/http.dart' as http;

abstract class RefreshTokenRemote {
  Future<RefreshTokenResponse> refreshToken(
      RefreshTokenRequest refreshTokenRequest);
}

class RefreshTokenRemoteImpl implements RefreshTokenRemote {
  static const refreshTokenEndpoint =
      ApiConstants.baseCommonApiUrl + ApiConstants.refreshTokenUrl;
  final HeaderProvider _apiHeaderProvider;

  RefreshTokenRemoteImpl(this._apiHeaderProvider);

  @override
  Future<RefreshTokenResponse> refreshToken(
      RefreshTokenRequest refreshTokenRequest) async {
    RefreshTokenResponse res;
    final headers = _apiHeaderProvider();
    final response = await http.post(Uri.parse(refreshTokenEndpoint),
        body: json.encode(refreshTokenRequest), headers: headers);

    log("RefreshToken rEQ out of 200: ${json.encode(refreshTokenRequest)}");

    log("RefreshToken Response out of 200: ${json.decode(json.encode(response.body))}");

    if (response.statusCode == 200) {
      // debugPrint("in 200");
      // final Map<String, dynamic> map = jsonDecode(response.body);
      // final code = map['header']['responseCode'];
      // log("code:$code");
      // if (code == "200") {
      //   res = refreshTokenResponseFromJson(response.body);
      //   print("in 200 -->200");
      //   return res;
      // } else {
      //   throw ServerException(
      //     message: map['message'],
      //     statusCode: code,
      //   );
      // }
      res = refreshTokenResponseFromJson(response.body);
      return res;
    } else {
      final errorBody = jsonDecode(response.body);
      final errorMessage = errorBody['error']['message'];

      throw ServerException(
        message: errorMessage,
        statusCode: response.statusCode,
      );
    }
  }
}
