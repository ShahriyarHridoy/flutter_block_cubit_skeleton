// To parse this JSON data, do
//
//     final refreshTokenRequest = refreshTokenRequestFromJson(jsonString);

import 'dart:convert';

RefreshTokenRequest refreshTokenRequestFromJson(String str) =>
    RefreshTokenRequest.fromJson(json.decode(str));

String refreshTokenRequestToJson(RefreshTokenRequest data) =>
    json.encode(data.toJson());

class RefreshTokenRequest {
  String refreshToken;

  RefreshTokenRequest({
    required this.refreshToken,
  });

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      RefreshTokenRequest(
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
      };
}
