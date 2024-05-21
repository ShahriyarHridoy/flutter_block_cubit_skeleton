import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/core/constant/api_constants.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/header_provider/header_provider.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/data/model/check_otp_response.dart';
import 'package:http/http.dart' as http;

import '../model/otp_validate_request.dart';

abstract class OtpValidateRemote {
  Future<CheckOtpResponse> otpValidate(OtpValidateRequest checkOtpRequest);
}

class OtpValidateRemoteImpl implements OtpValidateRemote {
  static const checkOtpEndpoint =
      ApiConstants.baseCommonApiUrl + ApiConstants.checkOtpUrl;
  final HeaderProvider _apiHeaderProvider;

  OtpValidateRemoteImpl(this._apiHeaderProvider);

  @override
  Future<CheckOtpResponse> otpValidate(
      OtpValidateRequest otpValidateRequest) async {
    CheckOtpResponse res;
    final headers = _apiHeaderProvider();
    final response = await http.post(Uri.parse(checkOtpEndpoint),
        body: json.encode(otpValidateRequest), headers: headers);

    log("rEQ out of 200: ${json.encode(otpValidateRequest)}");

    log("Response out of 200: ${json.decode(json.encode(response.body))}");

    if (response.statusCode == 200) {
      debugPrint("in 200");
      // final Map<String, dynamic> map = jsonDecode(response.body);
      // final code = map['header']['responseCode'];
      // log("code:$code");
      // if (code == "200") {
      //   res = checkOtpResponseFromJson(response.body);
      //   print("in 200 -->200");
      //   return res;
      // } else {
      //   throw ServerException(
      //     message: map['message'],
      //     statusCode: code,
      //   );
      // }
      res = checkOtpResponseFromJson(response.body);
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
