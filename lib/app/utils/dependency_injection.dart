import 'package:dio/dio.dart';

import 'package:get/get.dart';

class DependecyInjection {
  static void init() {
    Get.lazyPut(
        () => Dio(
              BaseOptions(baseUrl: 'https://apidev.ewally.com.br'),
            ),
        fenix: true);
  }
}
