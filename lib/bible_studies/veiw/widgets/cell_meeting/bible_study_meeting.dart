import 'package:church_app/bible_studies/controller/bible_study_meeting_controller.dart';
import 'package:church_app/core/widget/material_container.dart';
import 'package:church_app/core/widget/material_text_tield.dart';
import 'package:church_app/home_cell/model/cell_meeting_model.dart';
import 'package:church_app/utils/genetal_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AddBibleStudyMeeting extends StatefulWidget {
  final String cell;
  AddBibleStudyMeeting(this.cell);

  @override
  _AddBibleStudyMeetingState createState() => _AddBibleStudyMeetingState();
}

class _AddBibleStudyMeetingState extends State<AddBibleStudyMeeting> {
  TextEditingController cellNameController = TextEditingController();
  TextEditingController totalMemberController = TextEditingController();
  TextEditingController eldersController = TextEditingController();
  TextEditingController maleController = TextEditingController();
  TextEditingController femaleController = TextEditingController();
  TextEditingController childrenController = TextEditingController();
  TextEditingController deaconController = TextEditingController();
  TextEditingController deaconessController = TextEditingController();
  TextEditingController offeringController = TextEditingController();
  DateTime focus = DateTime.now();
  DateTime sameDay = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cellNameController = TextEditingController(text: widget.cell);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cellNameController.dispose();
    totalMemberController.dispose();
    eldersController.dispose();
    maleController.dispose();
    femaleController.dispose();
    childrenController.dispose();
    deaconController.dispose();
    deaconessController.dispose();
    offeringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: 500,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MaterialTextField(
                        controller: cellNameController,
                        info: 'Cell Name',
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      MaterialTextField(
                        controller: totalMemberController,
                        info: 'Total Member',
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          } else if (!amountString(value)) {
                            return 'Letter not allowed in this field';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      MaterialTextField(
                        controller: maleController,
                        info: 'Total Male',
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          } else if (!amountString(value)) {
                            return 'Letter not allowed in this field';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      MaterialTextField(
                        controller: femaleController,
                        info: 'Total Female',
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          } else if (!amountString(value)) {
                            return 'Letter not allowed in this field';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      MaterialTextField(
                        controller: eldersController,
                        info: 'Total Elders',
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          } else if (!amountString(value)) {
                            return 'Letter not allowed in this field';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      MaterialTextField(
                        controller: childrenController,
                        info: 'Total Children',
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          } else if (!amountString(value)) {
                            return 'Letter not allowed in this field';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      MaterialTextField(
                        controller: deaconController,
                        info: 'Total Deacons',
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          } else if (!amountString(value)) {
                            return 'Letter not allowed in this field';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      MaterialTextField(
                        controller: deaconessController,
                        info: 'Total Deaconesses',
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          } else if (!amountString(value)) {
                            return 'Letter not allowed in this field';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      MaterialTextField(
                        controller: offeringController,
                        info: 'Offering',
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'Required';
                          } else if (!amountString(value)) {
                            return 'Letter not allowed in this field';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      MaterialContainer(
                        info: 'Pick Date',
                        child: TableCalendar(
                          focusedDay: focus,
                          firstDay: DateTime(1 - 1 - 2010),
                          lastDay: DateTime.now(),
                          selectedDayPredicate: (day) {
                            return isSameDay(sameDay, day);
                          },
                          onDaySelected: (date, focusDate) {
                            setState(() {
                              sameDay = date;
                              focus = focusDate;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BibleStudyMeetingModel model =
                                BibleStudyMeetingModel(
                              cellName: cellNameController.text,
                              date: formattedDate(focus),
                              males: int.parse(maleController.text),
                              females: int.parse(femaleController.text),
                              children: int.parse(childrenController.text),
                              elders: int.parse(eldersController.text),
                              deacons: int.parse(deaconController.text),
                              deaconesses: int.parse(deaconessController.text),
                              offering: double.parse(offeringController.text),
                              rawDate: focus,
                              monthYear: monthYearDate(focus),
                              year: yearDate(focus),
                              totalMember:
                                  int.parse(totalMemberController.text),
                            );

                            BibleStudyMeetingController().addCellMeeting(model);

                            // clear all controllers
                            cellNameController.clear();
                            totalMemberController.clear();
                            maleController.clear();
                            femaleController.clear();
                            eldersController.clear();
                            childrenController.clear();
                            deaconController.clear();
                            deaconessController.clear();
                            offeringController.clear();
                          }
                        },
                        child: Text('Save'),
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
          )
        ],
      ),
    );
  }
}
