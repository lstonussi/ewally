import 'package:ewally/app/data/provider/login_api.dart';
import 'package:get/get.dart';

class LoginRepository {
  final LoginApi _api = Get.find<LoginApi>();
  Future<String> login(String user, String pass) {
    return _api.login(user, pass);
  }
}
