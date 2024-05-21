import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter_block_cubit_skeleton/core/constant/api_constants.dart';
import 'package:flutter_block_cubit_skeleton/core/header_provider/header_provider.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/data/model/sign_up_request.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/data/model/sign_up_response.dart';

abstract class SignUpRemote {
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest);
}

class SignUpRemoteImpl implements SignUpRemote {
  static const signUpEndpoint =
      ApiConstants.baseCommonApiUrl + ApiConstants.signUpUrl;
  final HeaderProvider _apiHeaderProvider;

  SignUpRemoteImpl(this._apiHeaderProvider);

  @override
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest) async {
    SignUpResponse res;
    final headers = _apiHeaderProvider();
    // final response = await http.post(Uri.parse(signUpEndpoint),
    //     body: json.encode(signUpRequest), headers: headers);

    final random = math.Random();
    int randomNumber = 100000 + random.nextInt(90000);

    final response = ''' {
  "status": 200,
  "message": "Sign-up successful",
  "data": {
    "accessToken": "testAccessToken",
    "refreshToken": "testRefreshToken",
    "fullName": "${signUpRequest.fullName}",
    "email": "${signUpRequest.email}",
    "otp": $randomNumber
  }
}
''';

//     final response = ''' {
//   "status": 200,
//   "message": "Sign-up successful",
//   "data": {
//     "accessToken": "testAccessToken",
//     "refreshToken": "testRefreshToken",
//     "fullName": "${signUpRequest.fullName}",
//     "email": "${signUpRequest.email}"
//   }
// }
// ''';

    log("rEQ out of 200: ${json.encode(signUpRequest)}");

    //log("Response out of 200: ${json.decode(json.encode(response.body))}");

    //if (response.statusCode == 200) {
    if (true) {
      debugPrint("in 200");

      res = signUpResponseFromJson(response);
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
