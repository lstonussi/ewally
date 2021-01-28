import 'dart:async';

import 'package:ewally/app/utils/generics.dart';
import 'package:get/get.dart';

class AuthHomeController extends GetxController {
  final RxBool isAuth = false.obs;
  Generics generics = Generics();

  Future<bool> get getIsAuth async {
    return isAuth.value = await generics.tryAutoLogin();
  }
}
