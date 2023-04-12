import 'package:church_app/finance/graph/view/widgets/income_expenditure_graph.dart';
import 'package:church_app/finance/monthly_overview/view/monthly_finance_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinanceGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Finance Data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => MonthlyFinanceTest());
                        },
                        child: Text('Details'))
                  ],
                ),
              ),
              Divider(),
              Expanded(child: IncomeExpenditureChart.withSampleData()),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.teal,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Income'),
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Expenditure')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
