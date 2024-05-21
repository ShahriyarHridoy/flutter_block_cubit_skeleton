import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/core/constant/api_constants.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/header_provider/header_provider.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/data/model/update_profile_request.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/data/model/update_profile_response.dart';
import 'package:http/http.dart' as http;

abstract class UpdateProfileRemote {
  Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequest updateProfileRequest);
}

class UpdateProfileRemoteImpl implements UpdateProfileRemote {
  static const updateProfileEndpoint =
      ApiConstants.baseCommonApiUrl + ApiConstants.updateProfileUrl;
  final HeaderProvider _apiHeaderProvider;

  UpdateProfileRemoteImpl(this._apiHeaderProvider);

  @override
  Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequest updateProfileRequest) async {
    UpdateProfileResponse res;
    final headers = _apiHeaderProvider();
    final response = await http.post(Uri.parse(updateProfileEndpoint),
        body: json.encode(updateProfileRequest), headers: headers);

    log("rEQ out of 200: ${json.encode(updateProfileRequest)}");

    log("Response out of 200: ${json.decode(json.encode(response.body))}");

    if (response.statusCode == 200) {
      debugPrint("in 200");
      // final Map<String, dynamic> map = jsonDecode(response.body);
      // final code = map['header']['responseCode'];
      // log("code:$code");
      // if (code == "200") {
      //   res = updateProfileResponseFromJson(response.body);
      //   print("in 200 -->200");
      //   return res;
      // } else {
      //   throw ServerException(
      //     message: map['message'],
      //     statusCode: code,
      //   );
      // }
      res = updateProfileResponseFromJson(response.body);
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
