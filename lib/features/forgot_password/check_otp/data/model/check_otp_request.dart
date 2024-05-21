// To parse this JSON data, do
//
//     final checkOtpRequest = checkOtpRequestFromJson(jsonString);

import 'dart:convert';

CheckOtpRequest checkOtpRequestFromJson(String str) =>
    CheckOtpRequest.fromJson(json.decode(str));

String checkOtpRequestToJson(CheckOtpRequest data) =>
    json.encode(data.toJson());

class CheckOtpRequest {
  String email;
  int otp;

  CheckOtpRequest({
    required this.email,
    required this.otp,
  });

  factory CheckOtpRequest.fromJson(Map<String, dynamic> json) =>
      CheckOtpRequest(
        email: json["email"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
      };
}
