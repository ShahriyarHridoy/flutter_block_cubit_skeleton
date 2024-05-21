import 'dart:convert';

SignInResponseToken signInResponseTokenFromJson(String str) =>
    SignInResponseToken.fromJson(json.decode(str));

String signInResponseTokenToJson(SignInResponseToken data) =>
    json.encode(data.toJson());

class SignInResponseToken {
  SignInResponseToken({
    required this.accessToken,
    required this.tokenType,
    required this.accessTokenExpireIn,
  });

  String accessToken;
  String tokenType;
  String accessTokenExpireIn;

  factory SignInResponseToken.fromJson(Map<String, dynamic> json) =>
      SignInResponseToken(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        accessTokenExpireIn: json["access_token_expire_in"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "access_token_expire_in": accessTokenExpireIn,
      };
}
