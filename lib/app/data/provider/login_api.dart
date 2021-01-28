import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

class LoginApi {
  final Dio _dio = Get.find<Dio>();
  Future<String> login(String user, String pass) async {
    var params = {
      "username": 'testFrontEwally',
      "password": '123456',
    };
    Response response = await _dio.post(
      '/user/login',
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
      data: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      return response.data['token'];
    } else
      return '';
  }
}
