// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String message;
  String accessToken;

  LoginModel({
    required this.message,
    required this.accessToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        accessToken: json["accessToken"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "accessToken": accessToken,
      };
}
