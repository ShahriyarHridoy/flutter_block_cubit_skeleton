import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/core/constant/api_constants.dart';
import 'package:flutter_block_cubit_skeleton/core/header_provider/header_provider.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/model/sign_in_request.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/model/sign_in_response.dart';

abstract class SignInRemote {
  Future<SignInResponse> signIn(SignInRequest signInRequest);
}

class SignInRemoteImpl implements SignInRemote {
  static const signInEndpoint =
      ApiConstants.baseCommonApiUrl + ApiConstants.signInUrl;
  final HeaderProvider _apiHeaderProvider;

  SignInRemoteImpl(this._apiHeaderProvider);

  @override
  Future<SignInResponse> signIn(SignInRequest signInRequest) async {
    SignInResponse res;
    final headers = _apiHeaderProvider();
    // final response = await http.post(Uri.parse(signInEndpoint),
    //     body: json.encode(signInRequest), headers: headers);
    String response = '''
  {
    "status": 200,
    "message": "Sign-in successful",
    "data": {
      "accessToken": "testAccessToken",
      "refreshToken": "testRefreshToken",
      "fullName": "Test test",
      "email": "${signInRequest.email}"
    }
  }
  ''';

    log("rEQ out of 200: ${json.encode(signInRequest)}");

    log("Response out of 200: ${json.decode(json.encode(response))}");

    // if (response.statusCode == 200)
    if (true) {
      debugPrint("in 200");
      // final Map<String, dynamic> map = jsonDecode(response.body);
      // final code = map['header']['responseCode'];
      // log("code:$code");
      // if (code == "200") {
      //   res = signInResponseFromJson(response.body);
      //   print("in 200 -->200");
      //   return res;
      // } else {
      //   throw ServerException(
      //     message: map['message'],
      //     statusCode: code,
      //   );
      // }
      res = signInResponseFromJson(response);
      return res;
    } else {
      // final errorBody = jsonDecode(response.body);
      // final errorMessage = errorBody['error']['message'];
      //
      // throw ServerException(
      //   message: errorMessage,
      //   statusCode: response.statusCode,
      // );
    }
  }
}
