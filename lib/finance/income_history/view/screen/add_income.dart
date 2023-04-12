import 'package:church_app/finance/income_history/controller/income_history_controller.dart';
import 'package:church_app/finance/income_history/model/income_history_model.dart';
import 'package:church_app/utils/genetal_strings.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class AddIncome extends StatefulWidget {
  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  DateTime focusDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  String selectedStream = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.teal[50],
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Container(
                      width: 500,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Amount',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Divider(),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Required";
                                      } else if (!value.isNumericOnly) {
                                        return 'Amount should not contain letters';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: controller,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Amount'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Select Date Received',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Divider(),
                                  TableCalendar(
                                    firstDay: DateTime.utc(2010, 10, 16),
                                    lastDay: DateTime.utc(2030, 3, 14),
                                    focusedDay: focusDay,
                                    selectedDayPredicate: (day) {
                                      return isSameDay(selectedDay, day);
                                    },
                                    onDaySelected: (date, focusDate) {
                                      setState(() {
                                        selectedDay = date;
                                        focusDay = focusDate;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Select Income Type',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Divider(),
                                  ValueListenableBuilder(
                                    valueListenable:
                                        Hive.box(kHiveIncomeStreamBox)
                                            .listenable(),
                                    builder: (_, Box box, __) =>
                                        ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: box.length,
                                      itemBuilder: (context, index) {
                                        return Material(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              selectedStream == box.getAt(index)
                                                  ? Colors.teal[100]
                                                  : Colors.transparent,
                                          child: ListTile(
                                            onTap: () {
                                              setState(
                                                () {
                                                  selectedStream =
                                                      box.getAt(index);
                                                },
                                              );
                                            },
                                            title: Text(box.getAt(index)),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (formKey.currentState.validate()) {
                                IncomeHistoryModel model = IncomeHistoryModel(
                                    incomeType: selectedStream,
                                    amount: double.tryParse(controller.text),
                                    dateAdded: formattedDate(DateTime.now()),
                                    dateReceived: formattedDate(focusDay),
                                    monthYear: monthYearDate(focusDay));
                                if (selectedStream == '') {
                                  Get.defaultDialog(
                                    content: Text('Select Income Stream'),
                                  );
                                } else {
                                  IncomeHistoryController().addIncome(
                                      model, monthYearDate(focusDay));
                                  controller.clear();
                                }
                              }
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.teal,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
