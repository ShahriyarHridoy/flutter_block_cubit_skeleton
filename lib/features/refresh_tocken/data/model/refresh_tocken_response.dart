// To parse this JSON data, do
//
//     final refreshTokenResponse = refreshTokenResponseFromJson(jsonString);

import 'dart:convert';

RefreshTokenResponse refreshTokenResponseFromJson(String str) =>
    RefreshTokenResponse.fromJson(json.decode(str));

String refreshTokenResponseToJson(RefreshTokenResponse data) =>
    json.encode(data.toJson());

class RefreshTokenResponse {
  int? status;
  String? message;
  Data? data;

  RefreshTokenResponse({
    this.status,
    this.message,
    this.data,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      RefreshTokenResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? accessToken;
  String? refreshToken;
  String? fullName;
  String? email;

  Data({
    this.accessToken,
    this.refreshToken,
    this.fullName,
    this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        fullName: json["fullName"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "fullName": fullName,
        "email": email,
      };
}
