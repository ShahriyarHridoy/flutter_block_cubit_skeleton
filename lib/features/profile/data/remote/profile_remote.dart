import 'dart:convert';
import 'dart:developer';

import 'package:flutter_block_cubit_skeleton/core/constant/api_constants.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/header_provider/header_provider.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/data/model/profile_response.dart';
import 'package:http/http.dart' as http;

abstract class ProfileRemote {
  Future<ProfileResponse> profile();
}

class ProfileRemoteImpl implements ProfileRemote {
  static const profileEndpoint =
      ApiConstants.baseCommonApiUrl + ApiConstants.profile;
  final HeaderProvider _apiHeaderProvider;

  ProfileRemoteImpl(this._apiHeaderProvider);

  @override
  Future<ProfileResponse> profile() async {
    ProfileResponse res;
    final headers = _apiHeaderProvider();
    log("header ::::  ${json.encode(headers)}");

    final response =
        await http.get(Uri.parse(profileEndpoint), headers: headers);
    log(json.encode(response.body));
    if (response.statusCode == 200) {
      // final Map<String, dynamic> map = jsonDecode(response.body);
      // final code = map['code'];
      res = profileResponseFromJson(response.body);

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
