import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:http/http.dart';

abstract class ResponseHandler {
  void handle(Response httpResponse);
}

class ResponseHandlerImpl implements ResponseHandler {
  @override
  void handle(Response response) {
    debugPrint('response: ${response.body}');
    if (response.statusCode != 200) {
      throw ServerException(
        message: "Internal server error ${response.statusCode}",
        statusCode: response.statusCode,
      );
    }
    final Map<String, dynamic> map = json.decode(response.body);
    final statusCode = map["code"];
    if (statusCode != 200) {
      throw ServerException(
        message: map["message"],
        statusCode: statusCode,
      );
    }
  }
}
