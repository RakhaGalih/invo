import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:invo/api_config/url.dart';
import 'package:invo/model/addProductModel.dart';
import 'package:invo/model/detailBarCodeModel.dart';
import 'package:invo/model/detailBarCodeModel.dart';
import 'package:invo/model/logoutModel.dart';
import 'package:invo/model/logoutModel.dart';
import 'package:invo/model/productModel.dart';
import 'package:invo/model/productModel.dart';
import 'package:invo/model/refreshModel.dart';
import 'package:invo/model/refreshModel.dart';
import 'package:invo/model/registModel.dart';
import 'package:invo/model/updateModel.dart';
import 'package:invo/model/updateModel.dart';
import 'package:invo/model/userModel.dart';
import 'package:invo/model/userModel.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/loginModel.dart';
import '../model/reportModel.dart';

class Api {
  Future<LoginModel> getLogin(
      {required String username, required String password}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final body = {"username": username, "password": password};
    print("RAW LOGIN: $body");
    print("URL LOGIN: ${Url.baseUrl}${Url.login}");
    final res = await http
        .post(Uri.parse(Url.baseUrl + Url.login),
            headers: headers, body: jsonEncode(body))
        .timeout(const Duration(seconds: 20));
    print("STATUS CODE(LOGIN): ${res.statusCode}");
    print("RES LOGIN: ${res.body}");
    if (res.statusCode == 200) {
      //SET COOKIES
      String? cookies = res.headers['set-cookie'];
      print("COOKIES: $cookies");
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (cookies != null) {
        await pref.setString('cookies', cookies);
      }

      return LoginModel.fromJson(jsonDecode(res.body));
    } else {
      print(res.statusCode);
      throw HttpException('request error code ${res.statusCode}');
    }
  }

  Future<RegistModel> getRegister(
      {required String email,
      required String username,
      required String password}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final body = {"email": email, "username": username, "password": password};
    print("RAW REGISTER: $body");
    print("URL REGISTER: ${Url.baseUrl}${Url.register}");
    final res = await http
        .post(Uri.parse(Url.baseUrl + Url.register),
            headers: headers, body: jsonEncode(body))
        .timeout(const Duration(seconds: 20));
    print("STATUS CODE(REGISTER): ${res.statusCode}");
    print("RES REGISTER: ${res.body}");
    if (res.statusCode == 201) {
      return RegistModel.fromJson(jsonDecode(res.body));
    } else {
      print(res.statusCode);
      throw HttpException('request error code ${res.statusCode}');
    }
  }

  Future<UserModel> getUser({required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    print("URL USER: ${Url.baseUrl}${Url.user}");
    final res = await http
        .get(Uri.parse(Url.baseUrl + Url.user), headers: headers)
        .timeout(const Duration(seconds: 20));
    print("STATUS CODE(USER): ${res.statusCode}");
    print("RES USER: ${res.body}");
    if (res.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(res.body));
    } else {
      print(res.statusCode);
      throw HttpException('request error code ${res.statusCode}');
    }
  }

  Future<RefreshModel> doRefresh() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? cookies = pref.getString('cookies');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (cookies != null) 'cookie': cookies,
    };

    print("HEADER REFRESH: $headers");
    print("URL REFRESH: ${Url.baseUrl}${Url.refresh}");
    final res = await http
        .get(Uri.parse(Url.baseUrl + Url.refresh), headers: headers)
        .timeout(const Duration(seconds: 20));
    print("STATUS CODE(REFRESH): ${res.statusCode}");
    print("RES REFRESH: ${res.body}");
    if (res.statusCode == 200) {
      String? cookies = res.headers['set-cookie'];
      print("COOKIES: $cookies");
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (cookies != null) {
        await pref.setString('cookies', cookies);
      }

      return RefreshModel.fromJson(jsonDecode(res.body));
    } else {
      print(res.statusCode);
      throw HttpException('request error code ${res.statusCode}');
    }
  }

  Future<UpdateUserModel> updateUser(
      {required String token,
      required File file,
      required String phoneNumber,
      required String officeAddress}) async {
    var mimeType = lookupMimeType(file.path);
    var bytes = await File.fromUri(Uri.parse(file.path)).readAsBytes();
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final body = {
      "phone_number": phoneNumber,
      "office_address": officeAddress,
    };
    http.MultipartRequest request =
        http.MultipartRequest("PATCH", Uri.parse(Url.baseUrl + Url.updateUser));
    print("URL UPDATE: ${Url.baseUrl}${Url.updateUser}");
    http.MultipartFile multipartFile = await http.MultipartFile.fromBytes(
        'img', bytes,
        filename: basename(file.path),
        contentType: MediaType.parse(mimeType.toString()));
    request.fields.addAll(body);
    request.headers.addAll(headers);
    request.files.add(multipartFile);
    var streamedResponse = await request.send();
    var res = await http.Response.fromStream(streamedResponse);
    print("STATUS CODE(UPDATE): ${res.statusCode}");
    print("RES UPDATE: ${res.body}");
    if (res.statusCode == 200) {
      return UpdateUserModel.fromJson(jsonDecode(res.body));
    } else {
      print(res.statusCode);
      throw HttpException('request error code ${res.statusCode}');
    }
  }

  Future<LogoutModel> logout() async {
    //CALLING COOKIES
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? cookies = pref.getString('cookies');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (cookies != null) 'cookie': cookies,
    };

    print("HEADER LOGOUT: $headers");
    print("URL LOGOUT: ${Url.baseUrl}${Url.logout}");
    final res = await http
        .get(Uri.parse(Url.baseUrl + Url.logout), headers: headers)
        .timeout(const Duration(seconds: 20));
    print("STATUS CODE(LOGOUT): ${res.statusCode}");
    print("RES LOGOUT: ${res.body}");
    if (res.statusCode == 200) {
      return LogoutModel.fromJson(jsonDecode(res.body));
    } else {
      print(res.statusCode);
      throw HttpException('request error code ${res.statusCode}');
    }
  }

  Future<ProductModel> getProduct({required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    print("URL PRODUCTS: ${Url.baseUrl}${Url.product}");
    final res = await http
        .get(Uri.parse(Url.baseUrl + Url.product), headers: headers)
        .timeout(const Duration(seconds: 20));
    print("STATUS CODE(PRODUCTS): ${res.statusCode}");
    print("RES PRODUCTS: ${res.body}");
    if (res.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(res.body));
    } else {
      print(res.statusCode);
      throw HttpException('request error code ${res.statusCode}');
    }
  }

  Future<AddProductModel> addProduct(
      {required String name,
      required String category,
      required String quantity,
      required String price,
      required String productCode,
      required String location,
      required String description,
      required List<File> productImg,
      required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    final body = {
      "name": name,
      "category": category,
      "quantity": quantity,
      "price": price,
      "product_code": productCode,
      "location": location,
      "description": description,
    };

    var request =
        http.MultipartRequest("POST", Uri.parse(Url.baseUrl + Url.product));
    print("URL ADD PRODUCT: ${Url.baseUrl}${Url.product}");

    request.fields.addAll(body);
    request.headers.addAll(headers);

    for (var file in productImg) {
      print("UPLOAD");
      var mimeType = lookupMimeType(file.path);
      var bytes = await file.readAsBytes();

      http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
        'img',
        bytes,
        filename: basename(file.path),
        contentType: MediaType.parse(mimeType.toString()),
      );
      request.files.add(multipartFile);
      print("SELESAI UPLOAD");
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print("STATUS CODE(ADD PRODUCT): ${response.statusCode}");
    print("RES ADD PRODUCT: ${response.body}");

    if (response.statusCode == 201) {
      return AddProductModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw HttpException('request error code ${response.statusCode}');
    }
  }

  Future<DetailBarCodeModel> getDetailBarCode(
      {required String token, required String code}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    print("URL DETAIL PRODUCT: ${Url.baseUrl}${Url.detailBarCode}$code");
    final res = await http
        .get(Uri.parse(Url.baseUrl + Url.detailBarCode + code),
            headers: headers)
        .timeout(const Duration(seconds: 20));
    print("STATUS CODE(DETAIL PRODUCT): ${res.statusCode}");
    print("RES DETAIL PRODUCT: ${res.body}");
    if (res.statusCode == 200) {
      return DetailBarCodeModel.fromJson(jsonDecode(res.body));
    } else {
      print(res.statusCode);
      throw HttpException('request error code ${res.statusCode}');
    }
  }

  Future<ReportModel> getReports(
      {required String token,
      required String createdAfter,
      required String createdBefore}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    print(
        "URL REPORT: ${Url.baseUrl}${Url.reports}?createdAfter=$createdAfter&createdBefore=$createdBefore");
    final res = await http
        .get(
            Uri.parse(
                "${Url.baseUrl}${Url.reports}?createdAfter=$createdAfter&createdBefore=$createdBefore"),
            headers: headers)
        .timeout(const Duration(seconds: 20));
    print("STATUS CODE(REPORT): ${res.statusCode}");
    print("RES REPORT: ${res.body}");
    if (res.statusCode == 200) {
      return ReportModel.fromJson(jsonDecode(res.body));
    } else {
      print(res.statusCode);
      throw HttpException('request error code ${res.statusCode}');
    }
  }
}
