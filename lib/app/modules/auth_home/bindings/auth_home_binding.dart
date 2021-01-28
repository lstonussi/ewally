import 'package:ewally/app/data/provider/login_api.dart';
import 'package:ewally/app/data/provider/statement_api.dart';
import 'package:ewally/app/data/repositories/login_repository.dart';
import 'package:ewally/app/data/repositories/statement_repository.dart';
import 'package:ewally/app/modules/extrato/controllers/extrato_controller.dart';
import 'package:ewally/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:ewally/app/modules/auth_home/controllers/auth_home_controller.dart';

class AuthHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthHomeController>(
      () => AuthHomeController(),
    );
    Get.lazyPut<ExtratoController>(
      () => ExtratoController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.put(StatementApi(), permanent: true);
    Get.put(StatementRepository(), permanent: true);
    Get.put(LoginApi(), permanent: true);
    Get.put(LoginRepository(), permanent: true);
  }
}
