import 'dart:async';

import 'package:ewally/app/routes/app_pages.dart';
import 'package:ewally/app/shared/store.dart';
import 'package:get/get.dart';

class Generics {
  Timer _logoutTimer;
  String _token;

  static final Generics _generics = Generics._internal();

  factory Generics() {
    return _generics;
  }

  Generics._internal();

  Future<String> get token async {
    _token = await Store.getString("TOKEN");
    if (_token != null)
      return _token;
    else
      return null;
  }

  Future<bool> get isAuth async {
    return await token != null;
  }

  Future<bool> tryAutoLogin() async {
    return isAuth;
  }

  void logout() {
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
      _logoutTimer = null;
    }
    Store.remove('TOKEN');
    Get.toNamed(Routes.AUTH_HOME);
  }

  void autoLogout() {
    final timeLogout = DateTime.now()
        .add(Duration(minutes: 15))
        .difference(DateTime.now())
        .inSeconds;
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
    }
    _logoutTimer = Timer(Duration(seconds: timeLogout), logout);
  }
}
