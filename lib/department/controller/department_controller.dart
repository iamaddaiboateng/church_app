import 'package:church_app/home_cell/model/home_cell_model.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:church_app/utils/notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DepartmentController with ChangeNotifier {
  Box departmentBox = Hive.box(kHiveBibleStudyBox);
  Box memberShipBox = Hive.box(kHiveChurchDatabase);

  String departmentName = '';
  List departmentMembers = [];
  BibleStudyModel homeCellModel = BibleStudyModel();

  Future<void> addHomeCell(BibleStudyModel model) async {
    departmentBox.add(model.toMap()).then((value) {
      successSnackBar('Department Added successfully');
    });
  }

  deleteDepartmentCell(index, String departmentName) {
    Get.defaultDialog(
      content: Text('Do you want to deleted $departmentName'),
      actions: [
        TextButton(
          onPressed: () {
            departmentBox.deleteAt(index).whenComplete(
              () {
                Get.back();
                successSnackBar('Department Deleted successfully');
              },
            );
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('No'),
        ),
      ],
    );
  }

  updateDepartmentData(key, BibleStudyModel model) {
    departmentBox.put(key, model.toMap()).whenComplete(() {
      Get.back();
      successSnackBar('Department was updated Successfully');
    });
  }

  getCellMembers(String cellName) {
    departmentMembers = memberShipBox.values
        .where((element) =>
            element['Department'].toString().toLowerCase() ==
            cellName.toLowerCase())
        .toList();

    notifyListeners();
  }

  setCellName(name) {
    departmentName = name;
    notifyListeners();
  }

  setHomeCell(BibleStudyModel model) {
    homeCellModel = model;
    notifyListeners();
  }
}
