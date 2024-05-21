// To parse this JSON data, do
//
//     final signUpRequest = signUpRequestFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

SignUpRequest signUpRequestFromJson(String str) =>
    SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  String fullName;
  String email;
  String password;

  SignUpRequest({
    required this.fullName,
    required this.email,
    required this.password,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "password": password,
      };
}
