import 'package:ewally/app/data/models/balance_model.dart';
import 'package:ewally/app/data/models/statement_model.dart';
import 'package:ewally/app/data/repositories/balance_repository.dart';
import 'package:ewally/app/data/repositories/statement_repository.dart';
import 'package:ewally/app/global_widgets/widgets.dart';
import 'package:ewally/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExtratoController extends GetxController {
  final statementRepository = Get.find<StatementRepository>();
  final balanceRepository = Get.find<BalanceRepository>();

  final RxList<StatementModel> listaStatement = <StatementModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingBalance = false.obs;
  final RxBool isShowingDetail = false.obs;
  final RxDouble balance = 0.0.obs;
  Rx<DateTime> selectedDateInitial = DateTime.now().obs;
  Rx<DateTime> selectedDateFinal = DateTime.now().obs;

  Future<void> loadStatement(DateTime dataIni, DateTime dataFin) async {
    try {
      isLoading.value = true;
      listaStatement.clear();
      var lista = await statementRepository.getStatement(dataIni, dataFin);
      listaStatement.assignAll(lista);
      isLoading.value = false;
    } catch (e) {
      showErroDialog(e.error);
    }
  }

  bool showDetail() {
    return isShowingDetail.value = !isShowingDetail.value;
  }

  Future<void> loadBalance() async {
    try {
      BalanceModel balance = await balanceRepository.getBalance();
      this.balance.value = balance.balanceConverted;
      isLoadingBalance.value = false;
    } catch (e) {
      showErroDialog(e.error);
    }
  }

  void showChart() {
    Get.toNamed(Routes.CHART, arguments: groupedTransactions);
  }

  @override
  void onReady() async {
    super.onReady();
    isLoadingBalance.value = true;
    //await loadStatement();
    await loadBalance();
  }

  onDateChangeFinal(DateTime dateTime) {
    selectedDateFinal.value = dateTime;
  }

  onDateChangeInitial(DateTime dateTime) {
    selectedDateInitial.value = dateTime;
  }

  List<Map<String, Object>> get groupedTransactions {
    int id = 0;

    return List.generate(
      listaStatement.length,
      (index) {
        //A logica acima: Usa o dia atual como referencia para chegar nos outros dias subtraindo o index
        id++;
        double max = 0.0;
        double min = 0.0;
        double total = 0.0;
        final date = DateTime.now().subtract(Duration(days: index));
        //date = DateFormat("dd/MM/yy").format(listaStatement[index].createdAt);

        for (var i = 0; i < listaStatement.length; i++) {
          bool sameDay = listaStatement[i].createdAt.day == date.day;
          bool sameMonth = listaStatement[i].createdAt.month == date.month;
          bool sameYear = listaStatement[i].createdAt.year == 2019;

          //Agrupar pela data
          if ((sameDay && sameMonth && sameYear)) {
            total += listaStatement[i].amountConverted;
          }

          //Achar o maior lançamento
          if ((max == 0.0) && (listaStatement[i].amountConverted > 0)) {
            max = listaStatement[i].amountConverted;
          } else {
            if (max < listaStatement[i].amountConverted) {
              max = listaStatement[i].amountConverted;
            }
          }

          //Achar o menor lançamento
          if ((min == 0.0) && (listaStatement[i].amountConverted < 0)) {
            min = listaStatement[i].amountConverted;
          } else {
            if (min < listaStatement[i].amountConverted) {
              min = listaStatement[i].amountConverted;
            }
          }
        }

        return {
          'id': id,
          'day': DateFormat("dd/MM/yy").format(date),
          'total': total,
          'max': max,
          'min': -min,
        };
      },
    ).toList();
  }
}
