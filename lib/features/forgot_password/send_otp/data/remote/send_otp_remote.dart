import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/core/constant/api_constants.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/header_provider/header_provider.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/model/send_otp_request.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/data/model/send_otp_response.dart';
import 'package:http/http.dart' as http;

abstract class SendOtpRemote {
  Future<SendOtpResponse> sendOtp(SendOtpRequest sendOtpRequest);
}

class SendOtpRemoteImpl implements SendOtpRemote {
  static const sendOtpEndpoint =
      ApiConstants.baseCommonApiUrl + ApiConstants.sendOtpUrl;
  final HeaderProvider _apiHeaderProvider;

  SendOtpRemoteImpl(this._apiHeaderProvider);

  @override
  Future<SendOtpResponse> sendOtp(SendOtpRequest sendOtpRequest) async {
    SendOtpResponse res;
    final headers = _apiHeaderProvider();
    final response = await http.post(Uri.parse(sendOtpEndpoint),
        body: json.encode(sendOtpRequest), headers: headers);

    log("rEQ out of 200: ${json.encode(sendOtpRequest)}");

    log("Response out of 200: ${json.decode(json.encode(response.body))}");

    if (response.statusCode == 200) {
      debugPrint("in 200");
      // final Map<String, dynamic> map = jsonDecode(response.body);
      // final code = map['header']['responseCode'];
      // log("code:$code");
      // if (code == "200") {
      //   res = sendOtpResponseFromJson(response.body);
      //   print("in 200 -->200");
      //   return res;
      // } else {
      //   throw ServerException(
      //     message: map['message'],
      //     statusCode: code,
      //   );
      // }
      res = sendOtpResponseFromJson(response.body);
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
