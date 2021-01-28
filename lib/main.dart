import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/dependency_injection.dart';

void main() {
  DependecyInjection.init();
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting('pt_BR');
  runApp(
    GetMaterialApp(
      title: "Ewally",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
