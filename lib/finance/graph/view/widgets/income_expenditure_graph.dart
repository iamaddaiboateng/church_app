import 'package:charts_flutter/flutter.dart' as chart;
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class IncomeExpenditureChart extends StatelessWidget {
  final List<chart.Series> series;
  final bool animate;

  IncomeExpenditureChart(this.series, this.animate);

  factory IncomeExpenditureChart.withSampleData() {
    return IncomeExpenditureChart(
      _generateData(),
      false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(kHiveIncomeHistoryBox).listenable(),
      builder: (_, Box box, __) => chart.PieChart(
        series,
      ),
    );
  }

  static List<chart.Series<DataModel, String>> _generateData() {
    Box incomeBox = Hive.box(kHiveIncomeHistoryBox);
    Box expenditureBox = Hive.box(kHiveExpenditureBox);

    List totalIncomeList = [];

    incomeBox.values.forEach((element) {
      totalIncomeList.add(element['amount']);
    });

    List totalExpendList = [];

    expenditureBox.values.forEach((element) {
      totalExpendList.add(element['amount']);
    });

    var expendTotal = 0.0;
    totalExpendList.forEach((element) {
      expendTotal += element;
    });

    var incomeTotal = 0.0;
    totalIncomeList.forEach((element) {
      incomeTotal += element;
    });

    var incomeList = [
      DataModel("Expenditure", expendTotal, Colors.red),
      DataModel("Income", incomeTotal, Colors.teal),
    ];

    return [
      chart.Series<DataModel, String>(
          data: incomeList,
          colorFn: (_, __) => chart.ColorUtil.fromDartColor(_.color),
          domainFn: (DataModel data, _) => data.field.toString(),
          measureFn: (DataModel data, _) => data.amount,
          id: 'income')
    ];
  }
}

class DataModel {
  final String field;
  final double amount;
  final Color color;

  DataModel(this.field, this.amount, this.color);
}
