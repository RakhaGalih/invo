import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:invo/api_config/url.dart';
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

import '../model/loginModel.dart';

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
    if (res.statusCode == 200) {
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

  Future<RefreshModel> doRefresh({required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    print("HEADER REFRESH: $headers");
    print("URL REFRESH: ${Url.baseUrl}${Url.refresh}");
    final res = await http
        .get(Uri.parse(Url.baseUrl + Url.refresh), headers: headers)
        .timeout(const Duration(seconds: 20));
    print("STATUS CODE(REFRESH): ${res.statusCode}");
    print("RES REFRESH: ${res.body}");
    if (res.statusCode == 200) {
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
      required String officeAddress,
      required String password}) async {
    var mimeType = lookupMimeType(file.path);
    var bytes = await File.fromUri(Uri.parse(file.path)).readAsBytes();
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final body = {
      "phone_number": phoneNumber,
      "office_address": officeAddress,
      "password": password
    };
    http.MultipartRequest request =
        http.MultipartRequest("PATCH", Uri.parse(Url.baseUrl + Url.updateUser));
    print("RAW UPDATE: $body");
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
}
