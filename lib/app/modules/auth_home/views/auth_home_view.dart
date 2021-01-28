import 'package:ewally/app/modules/extrato/views/extrato_view.dart';
import 'package:ewally/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ewally/app/modules/auth_home/controllers/auth_home_controller.dart';

class AuthHomeView extends GetView<AuthHomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isAuth.value ? ExtratoView() : LoginView(),
    );
  }
}
