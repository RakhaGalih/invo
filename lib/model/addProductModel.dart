// To parse this JSON data, do
//
//     final addProductModel = addProductModelFromJson(jsonString);

import 'dart:convert';

AddProductModel addProductModelFromJson(String str) =>
    AddProductModel.fromJson(json.decode(str));

String addProductModelToJson(AddProductModel data) =>
    json.encode(data.toJson());

class AddProductModel {
  String message;

  AddProductModel({
    required this.message,
  });

  factory AddProductModel.fromJson(Map<String, dynamic> json) =>
      AddProductModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
