import 'package:church_app/utils/hive_strings.dart';
import 'package:church_app/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class IncomeStreamController {
  var incomeStreamBox = Hive.box(kHiveIncomeStreamBox);

  _addIncomeStream(String income) {
    incomeStreamBox.add(income).whenComplete(
          () => successSnackBar(
            'Income Stream was added successfully',
          ),
        );
  }

  _deleteIncomeStream(int index) {
    incomeStreamBox
        .deleteAt(index)
        .whenComplete(() => successSnackBar('Item Deleted successfully'));
  }

  deletedIncomeDialog(index) {
    Get.defaultDialog(
        title: 'Delete Income',
        content:
            Text('Are you sure you will like to deleted this income stream?'),
        actions: [
          OutlinedButton(
            onPressed: () {
              Get.back();
              _deleteIncomeStream(index);
            },
            child: Text('Yes'),
          ),
        ]);
  }

  addIncomeStreamDialog() {
    GlobalKey<FormState> formKey = GlobalKey();
    TextEditingController controller = TextEditingController();

    Get.defaultDialog(
      title: 'Add Income Stream',
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: controller,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Required';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(hintText: 'Enter Income Stream'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  Get.back();
                  _addIncomeStream(controller.text);
                }
              },
              child: Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
