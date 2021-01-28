import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ewally/app/modules/chart/controllers/chart_controller.dart';

class ChartView extends GetView<ChartController> {
  final List<Map<String, Object>> groupedTransactions = Get.arguments;

  static const double barWidth = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: AspectRatio(
        aspectRatio: 0.8,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Expanded(
                child: Container(
                  width: (groupedTransactions.length * 65).toDouble(),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.center,
                      maxY: groupedTransactions[0]['max'],
                      minY: groupedTransactions[0]['min'],
                      groupsSpace: 15,
                      barTouchData: BarTouchData(
                        enabled: false,
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Colors.white, fontSize: 10),
                          margin: 10,
                          rotateAngle: 0,
                          reservedSize: 30,
                          getTitles: (double value) {
                            var a = groupedTransactions
                                .map((e) => e['day'])
                                .toList();
                            return a[value.toInt()];
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Colors.white, fontSize: 10),
                          rotateAngle: 45,
                          getTitles: (double value) {
                            if (value == 0) {
                              return '0';
                            }
                            return '${value.toInt()}k';
                          },
                          interval: 100,
                          margin: 8,
                          reservedSize: 30,
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        checkToShowHorizontalLine: (value) => value % 5 == 0,
                        getDrawingHorizontalLine: (value) {
                          if (value == 0) {
                            return FlLine(color: Colors.black, strokeWidth: 3);
                          }
                          return FlLine(
                            color: Colors.black,
                            strokeWidth: 0.8,
                          );
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: groupedTransactions.map(
                        (tr) {
                          return BarChartGroupData(
                            x: tr['id'],
                            barRods: [
                              BarChartRodData(
                                y: tr['total'],
                                width: barWidth,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6)),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
