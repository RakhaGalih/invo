// To parse this JSON data, do
//
//     final updateUser = updateUserFromJson(jsonString);

import 'dart:convert';

UpdateUserModel updateUserFromJson(String str) =>
    UpdateUserModel.fromJson(json.decode(str));

String updateUserToJson(UpdateUserModel data) => json.encode(data.toJson());

class UpdateUserModel {
  String message;

  UpdateUserModel({
    required this.message,
  });

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
