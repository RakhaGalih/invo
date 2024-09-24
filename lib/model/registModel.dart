// To parse this JSON data, do
//
//     final registModel = registModelFromJson(jsonString);

import 'dart:convert';

RegistModel registModelFromJson(String str) =>
    RegistModel.fromJson(json.decode(str));

String registModelToJson(RegistModel data) => json.encode(data.toJson());

class RegistModel {
  String message;

  RegistModel({
    required this.message,
  });

  factory RegistModel.fromJson(Map<String, dynamic> json) => RegistModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
