import 'package:charts_flutter/flutter.dart' as chart;
import 'package:church_app/finance/monthly_overview/controller/finance_monthly_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinanceDetailedMonthlyGraph extends StatelessWidget {
  final List<chart.Series> series;
  final bool animate;

  FinanceDetailedMonthlyGraph(this.series, this.animate);

  factory FinanceDetailedMonthlyGraph.withData(context) {
    return FinanceDetailedMonthlyGraph(_generateData(context), false);
  }

  @override
  Widget build(BuildContext context) {
    return chart.BarChart(series);
  }

  static List<chart.Series<FinanceMonthlyModel, String>> _generateData(
      context) {
    List<Map<String, dynamic>> dataList =
        Provider.of<FinanceMonthlyController>(context, listen: true)
            .filteredMaps;

    var incomeList = List.generate(
      dataList.length,
      (index) => FinanceMonthlyModel(
        month: dataList[index]['month'],
        amount: dataList[index]['income'],
      ),
    );

    var expenditureList = List.generate(
      dataList.length,
      (index) => FinanceMonthlyModel(
        month: dataList[index]['month'],
        amount: dataList[index]['expenditure'],
      ),
    );

    return [
      chart.Series<FinanceMonthlyModel, String>(
          data: incomeList,
          id: 'incomeData',
          colorFn: (_, __) => chart.MaterialPalette.teal.shadeDefault,
          domainFn: (data, _) => data.month,
          measureFn: (data, _) => data.amount),
      chart.Series<FinanceMonthlyModel, String>(
          data: expenditureList,
          id: 'expenditureData',
          colorFn: (_, __) => chart.MaterialPalette.red.shadeDefault,
          domainFn: (data, _) => data.month,
          measureFn: (data, _) => data.amount),
    ];
  }
}

class FinanceMonthlyModel {
  final String month;
  final double amount;
  final Color color;

  FinanceMonthlyModel({this.month, this.amount, this.color});
}
