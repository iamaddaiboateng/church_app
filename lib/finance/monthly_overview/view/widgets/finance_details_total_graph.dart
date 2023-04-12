import 'package:charts_flutter/flutter.dart' as charts;
import 'package:church_app/finance/monthly_overview/controller/finance_monthly_controller.dart';
import 'package:church_app/finance/monthly_overview/view/widgets/finance_detailed_monthly_graph.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinanceDetailTotalChart extends StatelessWidget {
  final List<charts.Series> series;
  final bool animate;

  FinanceDetailTotalChart(this.series, this.animate);

  factory FinanceDetailTotalChart.withData(context) {
    return FinanceDetailTotalChart(generateData(context), false);
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      series,
      animate: animate,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );
  }

  static List<charts.Series<FinanceMonthlyModel, String>> generateData(
      context) {
    final financeController = Provider.of<FinanceMonthlyController>(context);

    var totalIncome = [
      FinanceMonthlyModel(
          month: 'Income',
          amount: financeController.totalIncome,
          color: Colors.teal),
    ];

    var totalExpenditure = [
      FinanceMonthlyModel(
          month: 'Expenditure',
          amount: financeController.totalExpenditure,
          color: Colors.red),
    ];

    return [
      charts.Series<FinanceMonthlyModel, String>(
          data: totalExpenditure,
          id: 'expenditure',
          colorFn: (data, _) => charts.ColorUtil.fromDartColor(data.color),
          domainFn: (data, _) => data.month,
          measureFn: (data, _) => data.amount,
          labelAccessorFn: (data, _) => "${data.month}: ${data.amount}"),
      charts.Series<FinanceMonthlyModel, String>(
          data: totalIncome,
          id: 'income',
          domainFn: (data, _) => data.month,
          measureFn: (data, _) => data.amount,
          colorFn: (data, _) => charts.ColorUtil.fromDartColor(data.color),
          labelAccessorFn: (data, _) => "${data.month}: ${data.amount}"),
    ];
  }
}
