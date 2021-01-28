import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErroDialog(String msg) {
  Get.defaultDialog(
    title: 'Erro',
    content: Text(msg),
    confirm: FlatButton(
      child: Text('Ok'),
      onPressed: () {
        Get.back();
      },
    ),
  );
}
