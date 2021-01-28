import 'package:ewally/app/data/models/balance_model.dart';
import 'package:ewally/app/data/provider/balance_api.dart';

import 'package:get/get.dart';

class BalanceRepository {
  final BalanceApi _api = Get.find<BalanceApi>();
  Future<BalanceModel> getBalance() {
    return _api.getBalance();
  }
}
