import 'package:ewally/app/data/repositories/login_repository.dart';
import 'package:ewally/app/global_widgets/widgets.dart';
import 'package:ewally/app/modules/auth_home/controllers/auth_home_controller.dart';
import 'package:ewally/app/routes/app_pages.dart';
import 'package:ewally/app/shared/store.dart';
import 'package:ewally/app/utils/generics.dart';
import 'package:ewally/exceptions/auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AuthMode {
  SignUp,
  SignIn,
}

class LoginController extends GetxController with SingleGetTickerProviderMixin {
  final loginRepository = Get.find<LoginRepository>();
  final authHome = Get.find<AuthHomeController>();

  GlobalKey<FormState> form = GlobalKey();
  final RxBool isLoading = false.obs;
  final Rx<AuthMode> authMode = AuthMode.SignIn.obs;
  final passController = TextEditingController();
  Generics _generics = Generics();
  final Map<String, String> authData = {
    'login': '',
    'pass': '',
  };

  Future<void> submit() async {
    // if (!form.currentState.validate()) {
    //   return;
    // }
    isLoading.value = true;
    form.currentState.save();
    try {
      final token = await signIn(
        authData['login'],
        authData['pass'],
      );
      _generics.autoLogout();
      if (token != '') {
        await Store.saveString('TOKEN', token);
        Get.offNamed(Routes.EXTRATO);
      }
    } on AuthException catch (error) {
      showErroDialog(error.toString());
    } catch (error) {
      showErroDialog('Ocorreu um erro inesperado.');
    }

    isLoading.value = false;
  }

  Future<String> signIn(String login, String pass) async {
    return loginRepository.login(login, pass);
  }
}
