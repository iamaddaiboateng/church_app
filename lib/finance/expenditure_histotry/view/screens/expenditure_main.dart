import 'package:church_app/finance/expenditure_histotry/model/expenditure_model.dart';
import 'package:church_app/finance/expenditure_histotry/view/screens/add_expenditure.dart';
import 'package:church_app/finance/income_history/view/widget/single_income_history_widget.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainExpenditure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Expenditure History',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Get.to(() => AddExpenditure());
                    },
                    child: Text('Add'))
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box(kHiveExpenditureBox).listenable(),
              builder: (_, Box box, __) => box.isEmpty
                  ? Center(
                      child: Text('No Expenditure Added'),
                    )
                  : Scrollbar(
                      child: ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          ExpenditureModel model =
                              ExpenditureModel.fromMap(box.getAt(index));

                          return SingleIncomeHistoryWidget(
                            amount: model.amount.toString(),
                            incomeStream: model.reason,
                            dateReceived: model.dateReceived,
                            dataAdded: model.dateAdded,
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
