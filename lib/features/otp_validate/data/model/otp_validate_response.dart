// To parse this JSON data, do
//
//     final checkOtpResponse = checkOtpResponseFromJson(jsonString);

import 'dart:convert';

CheckOtpResponse checkOtpResponseFromJson(String str) =>
    CheckOtpResponse.fromJson(json.decode(str));

String checkOtpResponseToJson(CheckOtpResponse data) =>
    json.encode(data.toJson());

class CheckOtpResponse {
  int status;
  String message;
  int data;

  CheckOtpResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CheckOtpResponse.fromJson(Map<String, dynamic> json) =>
      CheckOtpResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
