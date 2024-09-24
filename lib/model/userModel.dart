// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String email;
  String name;
  String birthyear;
  String username;
  String phoneNumber;
  String officeAddress;
  String img;

  UserModel({
    required this.email,
    required this.name,
    required this.birthyear,
    required this.username,
    required this.phoneNumber,
    required this.officeAddress,
    required this.img,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        name: json["name"] ?? "-",
        birthyear: json["birthyear"] ?? "-",
        username: json["username"],
        phoneNumber: json["phone_number"] ?? "-",
        officeAddress: json["office_address"] ?? "-",
        img: json["img"] ??
            "https://firebasestorage.googleapis.com/v0/b/evolphy-cfb2e.appspot.com/o/Rectangle%206.png?alt=media&token=2b96ff1a-6c58-478d-8c4d-482cf3ba02ef",
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "birthyear": birthyear,
        "username": username,
        "phone_number": phoneNumber,
        "office_address": officeAddress,
        "img": img,
      };
}
