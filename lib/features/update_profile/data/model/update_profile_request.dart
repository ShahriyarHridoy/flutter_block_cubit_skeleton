// To parse this JSON data, do
//
//     final updateProfileRequest = updateProfileRequestFromJson(jsonString);

import 'dart:convert';

UpdateProfileRequest updateProfileRequestFromJson(String str) =>
    UpdateProfileRequest.fromJson(json.decode(str));

String updateProfileRequestToJson(UpdateProfileRequest data) =>
    json.encode(data.toJson());

class UpdateProfileRequest {
  String fullName;
  String phone;
  String dateOfBirth;
  String address;

  UpdateProfileRequest({
    required this.fullName,
    required this.phone,
    required this.dateOfBirth,
    required this.address,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      UpdateProfileRequest(
        fullName: json["fullName"],
        phone: json["phone"],
        dateOfBirth: json["dateOfBirth"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phone": phone,
        "dateOfBirth": dateOfBirth,
        "address": address,
      };
}
