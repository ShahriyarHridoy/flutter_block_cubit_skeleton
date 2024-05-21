// To parse this JSON data, do
//
//     final checkOtpRequest = checkOtpRequestFromJson(jsonString);

import 'dart:convert';

OtpValidateRequest otpValidateRequestFromJson(String str) =>
    OtpValidateRequest.fromJson(json.decode(str));

String otpValidateRequestToJson(OtpValidateRequest data) =>
    json.encode(data.toJson());

class OtpValidateRequest {
  String email;
  int otp;

  OtpValidateRequest({
    required this.email,
    required this.otp,
  });

  factory OtpValidateRequest.fromJson(Map<String, dynamic> json) =>
      OtpValidateRequest(
        email: json["email"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
      };
}
