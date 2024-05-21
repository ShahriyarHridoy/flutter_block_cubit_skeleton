// To parse this JSON data, do
//
//     final resetPasswordRequest = resetPasswordRequestFromJson(jsonString);

import 'dart:convert';

ResetPasswordRequest resetPasswordRequestFromJson(String str) =>
    ResetPasswordRequest.fromJson(json.decode(str));

String resetPasswordRequestToJson(ResetPasswordRequest data) =>
    json.encode(data.toJson());

class ResetPasswordRequest {
  String email;
  int otp;
  String password;

  ResetPasswordRequest({
    required this.email,
    required this.otp,
    required this.password,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      ResetPasswordRequest(
        email: json["email"],
        otp: json["otp"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
        "password": password,
      };
}
