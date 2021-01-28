import 'package:ewally/app/modules/auth_home/views/auth_home_view.dart';
import 'package:ewally/app/modules/auth_home/bindings/auth_home_binding.dart';
import 'package:ewally/app/modules/chart/bindings/chart_binding.dart';
import 'package:ewally/app/modules/chart/views/chart_view.dart';
import 'package:ewally/app/modules/extrato/bindings/extrato_binding.dart';
import 'package:ewally/app/modules/extrato/views/extrato_view.dart';
import 'package:ewally/app/modules/login/views/login_view.dart';
import 'package:ewally/app/modules/login/bindings/login_binding.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.AUTH_HOME;

  static final routes = [
    GetPage(
      name: Routes.CHART,
      page: () => ChartView(),
      binding: ChartBinding(),
    ),
    GetPage(
      name: Routes.EXTRATO,
      page: () => ExtratoView(),
      binding: ExtratoBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.AUTH_HOME,
      page: () => AuthHomeView(),
      binding: AuthHomeBinding(),
    ),
  ];
}
