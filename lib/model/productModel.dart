// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String message;
  List<ProductData> data;

  ProductModel({
    required this.message,
    required this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        message: json["message"],
        data: List<ProductData>.from(
            json["data"].map((x) => ProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ProductData {
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

  ProductData({
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

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
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
