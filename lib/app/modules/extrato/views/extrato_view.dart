import 'package:ewally/app/modules/extrato/controllers/extrato_controller.dart';
import 'package:ewally/app/modules/extrato/views/widgets/adaptative_time_picker.dart';
import 'package:ewally/app/modules/extrato/views/widgets/extrato_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExtratoView extends GetView<ExtratoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extrato'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Divider(height: 1.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                    width: double.infinity,
                    child: Card(
                      child: Center(
                        child: controller.isLoadingBalance.value
                            ? CircularProgressIndicator()
                            : Column(
                                children: [
                                  Padding(
                                    child: Text('Saldo'),
                                    padding: EdgeInsets.all(10),
                                  ),
                                  Padding(
                                      child: Text(
                                        NumberFormat.currency(
                                                locale: 'pt_BR', symbol: 'R\$')
                                            .format(controller.balance),
                                      ),
                                      padding: EdgeInsets.all(10)),
                                ],
                              ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          AdaptativeDatePicker(
                            text: 'Selecionar Data Inicial',
                            selectedDate: controller.selectedDateInitial.value,
                            onDateChange: (date) {
                              controller.onDateChangeInitial(date);
                            },
                          ),
                          Text(DateFormat("dd/MM/yyyy")
                              .format(controller.selectedDateInitial.value)),
                        ],
                      ),
                      Text('até'),
                      Column(
                        children: [
                          AdaptativeDatePicker(
                            text: 'Selecionar Data Final',
                            selectedDate: controller.selectedDateFinal.value,
                            onDateChange: (date) {
                              controller.onDateChangeFinal(date);
                            },
                          ),
                          Text(DateFormat("dd/MM/yyyy")
                              .format(controller.selectedDateFinal.value)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  FlatButton(
                    color: Colors.grey[300],
                    child: Text('Pesquisar'),
                    onPressed: () {
                      controller.loadStatement(
                          controller.selectedDateInitial.value,
                          controller.selectedDateFinal.value);
                    },
                  ),
                  if (controller.listaStatement.length > 0)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: StatementTitle(
                          statementModel: controller.listaStatement[0],
                          showDetails: controller.showChart),
                    ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            Transaction(
                              transactions: controller.listaStatement,
                              showDetails: controller.isShowingDetail.value,
                            ),
                            Divider(height: 1.0),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
