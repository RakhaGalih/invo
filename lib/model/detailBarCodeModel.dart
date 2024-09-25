// To parse this JSON data, do
//
//     final detailBarCodeModel = detailBarCodeModelFromJson(jsonString);

import 'dart:convert';

DetailBarCodeModel detailBarCodeModelFromJson(String str) =>
    DetailBarCodeModel.fromJson(json.decode(str));

String detailBarCodeModelToJson(DetailBarCodeModel data) =>
    json.encode(data.toJson());

class DetailBarCodeModel {
  String message;
  DataBarCode data;

  DetailBarCodeModel({
    required this.message,
    required this.data,
  });

  factory DetailBarCodeModel.fromJson(Map<String, dynamic> json) =>
      DetailBarCodeModel(
        message: json["message"],
        data: DataBarCode.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class DataBarCode {
  int productId;
  String name;
  String category;
  int quantity;
  int sold;
  int price;
  String productCode;
  String location;
  String description;
  String img1;
  String img2;
  String img3;

  DataBarCode({
    required this.productId,
    required this.name,
    required this.category,
    required this.quantity,
    required this.sold,
    required this.price,
    required this.productCode,
    required this.location,
    required this.description,
    required this.img1,
    required this.img2,
    required this.img3,
  });

  factory DataBarCode.fromJson(Map<String, dynamic> json) => DataBarCode(
        productId: json["product_id"],
        name: json["name"],
        category: json["category"],
        quantity: json["quantity"],
        sold: json["sold"],
        price: json["price"],
        productCode: json["product_code"],
        location: json["location"],
        description: json["description"],
        img1: json["img1"],
        img2: json["img2"],
        img3: json["img3"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "category": category,
        "quantity": quantity,
        "sold": sold,
        "price": price,
        "product_code": productCode,
        "location": location,
        "description": description,
        "img1": img1,
        "img2": img2,
        "img3": img3,
      };
}
