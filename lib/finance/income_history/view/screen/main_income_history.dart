import 'package:church_app/finance/income_history/model/income_history_model.dart';
import 'package:church_app/finance/income_history/view/screen/add_income.dart';
import 'package:church_app/finance/income_history/view/widget/single_income_history_widget.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainIncomeHistory extends StatelessWidget {
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
                  'Income History',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Get.to(() => AddIncome());
                    },
                    child: Text('Add'))
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box(kHiveIncomeHistoryBox).listenable(),
              builder: (_, Box box, __) => box.isEmpty
                  ? Center(
                      child: Text('No Income Added'),
                    )
                  : Scrollbar(
                      child: ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          IncomeHistoryModel model =
                              IncomeHistoryModel.fromMap(box.getAt(index));
                          print(model.amount);
                          return SingleIncomeHistoryWidget(
                            amount: '${model.amount}',
                            incomeStream: model.incomeType,
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
