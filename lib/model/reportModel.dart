// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

import 'dart:convert';

ReportModel reportModelFromJson(String str) =>
    ReportModel.fromJson(json.decode(str));

String reportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  String message;
  ReportData data;

  ReportModel({
    required this.message,
    required this.data,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        message: json["message"],
        data: ReportData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class ReportData {
  String totalProduct;
  List<ProductReport> productReports;

  ReportData({
    required this.totalProduct,
    required this.productReports,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) => ReportData(
        totalProduct: json["totalProduct"],
        productReports: List<ProductReport>.from(
            json["productReports"].map((x) => ProductReport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalProduct": totalProduct,
        "productReports":
            List<dynamic>.from(productReports.map((x) => x.toJson())),
      };
}

class ProductReport {
  String name;
  List<Report> reports;

  ProductReport({
    required this.name,
    required this.reports,
  });

  factory ProductReport.fromJson(Map<String, dynamic> json) => ProductReport(
        name: json["name"],
        reports:
            List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "reports": List<dynamic>.from(reports.map((x) => x.toJson())),
      };
}

class Report {
  int reportId;
  int stockIn;
  int stockOut;
  int revenue;
  int productId;
  String year;
  String month;
  String day;

  Report({
    required this.reportId,
    required this.stockIn,
    required this.stockOut,
    required this.revenue,
    required this.productId,
    required this.year,
    required this.month,
    required this.day,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        reportId: json["report_id"],
        stockIn: json["stock_in"],
        stockOut: json["stock_out"],
        revenue: json["revenue"],
        productId: json["product_id"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "report_id": reportId,
        "stock_in": stockIn,
        "stock_out": stockOut,
        "revenue": revenue,
        "product_id": productId,
        "year": year,
        "month": month,
        "day": day,
      };
}
