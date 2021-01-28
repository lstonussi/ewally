import 'package:get/get.dart';
import 'package:ewally/app/modules/chart/controllers/chart_controller.dart';

class ChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChartController>(
      () => ChartController(),
    );
  }
}
