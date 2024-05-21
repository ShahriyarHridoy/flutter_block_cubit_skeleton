import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/core/constant/api_constants.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/header_provider/header_provider.dart';
import 'package:flutter_block_cubit_skeleton/core/resources/error_msg_res.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/data/model/change_password_request.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/data/model/change_password_response.dart';
import 'package:http/http.dart' as http;

abstract class ChangePasswordRemote {
  Future<ChangePasswordResponse> changePassword(
      ChangePasswordRequest changePasswordRequest);
}

class ChangePasswordRemoteImpl implements ChangePasswordRemote {
  static const changePasswordEndpoint =
      ApiConstants.baseCommonApiUrl + ApiConstants.changePasswordUrl;
  final HeaderProvider _apiHeaderProvider;

  ChangePasswordRemoteImpl(this._apiHeaderProvider);

  @override
  Future<ChangePasswordResponse> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    ChangePasswordResponse res;
    final headers = _apiHeaderProvider();
    final response = await http.post(Uri.parse(changePasswordEndpoint),
        body: json.encode(changePasswordRequest), headers: headers);

    log("rEQ out of 200: ${json.encode(changePasswordRequest)}");

    log("Response out of 200: ${json.decode(json.encode(response.body))}");

    if (response.statusCode == 200) {
      debugPrint("in 200");
      // final Map<String, dynamic> map = jsonDecode(response.body);
      // final code = map['header']['responseCode'];
      // log("code:$code");
      // if (code == "200") {
      //   res = changePasswordResponseFromJson(response.body);
      //   print("in 200 -->200");
      //   return res;
      // } else {
      //   throw ServerException(
      //     message: map['message'],
      //     statusCode: code,
      //   );
      // }
      res = changePasswordResponseFromJson(response.body);

      return res;
    } else {
      throw ServerException(
        message: ErrorMsgRes.kServerError,
        statusCode: response.statusCode,
      );
    }
  }
}
