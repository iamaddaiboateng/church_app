import 'package:church_app/finance/expenditure_histotry/controller/expenditure_controller.dart';
import 'package:church_app/finance/expenditure_histotry/model/expenditure_model.dart';
import 'package:church_app/utils/genetal_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AddExpenditure extends StatefulWidget {
  @override
  _AddExpenditureState createState() => _AddExpenditureState();
}

class _AddExpenditureState extends State<AddExpenditure> {
  DateTime focusDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  TextEditingController controller = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

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
                                      } else if (!amountString(
                                          controller.text)) {
                                        return 'Amount must not contain letter';
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
                            height: 10.0,
                          ),
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Reason',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Divider(),
                                  TextFormField(
                                    maxLines: null,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Required";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: reasonController,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Reason'),
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
                          InkWell(
                            onTap: () {
                              if (formKey.currentState.validate()) {
                                ExpenditureModel model = ExpenditureModel(
                                    reason: reasonController.text,
                                    amount: double.tryParse(controller.text),
                                    dateAdded: formattedDate(DateTime.now()),
                                    dateReceived: formattedDate(focusDay),
                                    monthYear: monthYearDate(focusDay));

                                ExpenditureController().addExpenditure(
                                    model, monthYearDate(focusDay));
                                controller.clear();
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
