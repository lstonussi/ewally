import 'package:ewally/app/data/models/statement_model.dart';
import 'package:ewally/app/data/provider/statement_api.dart';
import 'package:get/get.dart';

class StatementRepository {
  final StatementApi _api = Get.find<StatementApi>();
  Future<List<StatementModel>> getStatement(
      DateTime dateInitial, DateTime dateFinal) async {
    return await _api.getStatement(dateInitial, dateFinal);
  }
}
