import 'package:church_app/finance/sammury/view/widgets/income_summary_widget.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class IncomeSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(kHiveIncomeHistoryBox).listenable(),
      builder: (_, Box box, __) {
        List totalIncomeList = [];

        box.values.forEach((element) {
          totalIncomeList.add(element['amount']);
        });

        var incomeTotal = 0.0;
        totalIncomeList.forEach((element) {
          incomeTotal += element;
        });

        return ValueListenableBuilder(
          valueListenable: Hive.box(kHiveExpenditureBox).listenable(),
          builder: (_, Box expendBox, __) {
            List totalExpendList = [];

            expendBox.values.forEach((element) {
              totalExpendList.add(element['amount']);
            });

            var expendTotal = 0.0;
            totalExpendList.forEach((element) {
              expendTotal += element;
            });

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Financial Summary',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                                child: IncomeSummaryWidget(
                              color: Colors.blue,
                              amount: '$incomeTotal',
                              type: "Total Income",
                            )),
                            Expanded(
                                child: IncomeSummaryWidget(
                              color: Colors.teal,
                              amount: '$expendTotal',
                              type: 'Expenditure',
                            )),
                            Expanded(
                                child: IncomeSummaryWidget(
                              color: Colors.red,
                              amount: '${incomeTotal - expendTotal}',
                              type: "Cash-in-hand",
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
