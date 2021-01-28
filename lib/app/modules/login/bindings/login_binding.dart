import 'package:ewally/app/data/provider/login_api.dart';
import 'package:ewally/app/data/repositories/login_repository.dart';
import 'package:get/get.dart';
import 'package:ewally/app/modules/login/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.put(LoginApi(), permanent: true);
    Get.put(LoginRepository(), permanent: true);
  }
}
