import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/core/constant/api_constants.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/header_provider/header_provider.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/data/model/reset_password_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/data/model/reset_password_response.dart';
import 'package:http/http.dart' as http;

abstract class ResetPasswordRemote {
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest);
}

class ResetPasswordRemoteImpl implements ResetPasswordRemote {
  static const resetPasswordEndpoint =
      ApiConstants.baseCommonApiUrl + ApiConstants.resetPasswordUrl;
  final HeaderProvider _apiHeaderProvider;

  ResetPasswordRemoteImpl(this._apiHeaderProvider);

  @override
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    ResetPasswordResponse res;
    final headers = _apiHeaderProvider();
    final response = await http.post(Uri.parse(resetPasswordEndpoint),
        body: json.encode(resetPasswordRequest), headers: headers);

    log("rEQ out of 200: ${json.encode(resetPasswordRequest)}");

    log("Response out of 200: ${json.decode(json.encode(response.body))}");

    if (response.statusCode == 200) {
      debugPrint("in 200");
      // final Map<String, dynamic> map = jsonDecode(response.body);
      // final code = map['header']['responseCode'];
      // log("code:$code");
      // if (code == "200") {
      //   res = resetPasswordResponseFromJson(response.body);
      //   print("in 200 -->200");
      //   return res;
      // } else {
      //   throw ServerException(
      //     message: map['message'],
      //     statusCode: code,
      //   );
      // }
      res = resetPasswordResponseFromJson(response.body);
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
