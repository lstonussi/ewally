import 'package:ewally/app/data/provider/balance_api.dart';
import 'package:ewally/app/data/provider/statement_api.dart';
import 'package:ewally/app/data/repositories/balance_repository.dart';
import 'package:ewally/app/data/repositories/statement_repository.dart';
import 'package:ewally/app/modules/extrato/controllers/extrato_controller.dart';
import 'package:get/get.dart';

class ExtratoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtratoController>(
      () => ExtratoController(),
    );
    Get.put(StatementApi(), permanent: true);
    Get.put(StatementRepository(), permanent: true);
    Get.put(BalanceApi(), permanent: true);
    Get.put(BalanceRepository(), permanent: true);
  }
}
