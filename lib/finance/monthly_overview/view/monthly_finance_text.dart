import 'package:church_app/core/widget/material_container.dart';
import 'package:church_app/finance/monthly_overview/controller/finance_monthly_controller.dart';
import 'package:church_app/finance/monthly_overview/view/widgets/finance_detailed_monthly_graph.dart';
import 'package:church_app/finance/monthly_overview/view/widgets/finance_details_total_graph.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class MonthlyFinanceTest extends StatefulWidget {
  @override
  _MonthlyFinanceTestState createState() => _MonthlyFinanceTestState();
}

class _MonthlyFinanceTestState extends State<MonthlyFinanceTest> {
  // List<String> months = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceMonthlyController>(
      builder: (_, finance, __) => Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
                  child: FloatingActionButton(
                    mini: true,
                    child: Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Material(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Legend'),
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.teal,
                      ),
                      SizedBox(
                        width: 10,
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
                        width: 10,
                      ),
                      Text('Expenditure'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: MaterialContainer(
                  info: 'Available Months',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable:
                              Hive.box(kHiveFinanceMonthYearBox).listenable(),
                          builder: (_, Box box, __) => ListView.builder(
                              itemCount: box.length,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  onChanged: (value) {
                                    final month = box.getAt(index);
                                    finance.addValueToMonths(month);
                                  },
                                  value: finance.months.contains(
                                    box.getAt(index),
                                  )
                                      ? true
                                      : false,
                                  // onTap: () {
                                  //
                                  //
                                  //   finance.addValueToMonths(month);
                                  // },
                                  title: Text(box.getAt(index)),
                                );
                              }),
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                          onPressed: () {
                            finance.clearMonthsSet();
                          },
                          child: Text('Clear'))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: MaterialContainer(
                          info: 'Monthly Overview',
                          child: finance.months.isEmpty
                              ? Center(
                                  child: Text('No Month Selected'),
                                )
                              : FinanceDetailedMonthlyGraph.withData(context)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: MaterialContainer(
                        info: 'Income Source',
                        child: finance.months.isEmpty
                            ? Center(
                                child: Text('No Month Selected'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: finance.incomeSource.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                        '${finance.incomeSource.toList()[index]}'),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: MaterialContainer(
                          info: 'Total Revenue',
                          child: finance.months.isEmpty
                              ? Center(
                                  child: Text('No Month Selected'),
                                )
                              : FinanceDetailTotalChart.withData(context)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: MaterialContainer(
                        info: 'Expenses',
                        child: finance.months.isEmpty
                            ? Center(
                                child: Text('No Month Selected'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: finance.incomeOutlet.toList().length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                        '${finance.incomeOutlet.toList()[index]}'),
                                  );
                                },
                              ),
                      ),
                    ),
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
