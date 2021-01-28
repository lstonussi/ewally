import 'package:dio/dio.dart';
import 'package:ewally/app/data/models/balance_model.dart';
import 'package:ewally/app/utils/generics.dart';
import 'package:get/get.dart' hide Response;

class BalanceApi {
  final Dio _dio = Get.find<Dio>();

  Future<BalanceModel> getBalance() async {
    Generics _generics = Generics();
    final token = await _generics.token;
    Response response = await _dio.get(
      '/account/balance',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return BalanceModel.fromJson(response.data);
    } else
      return null;
  }
}
