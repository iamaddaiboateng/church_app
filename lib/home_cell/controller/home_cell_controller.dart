import 'package:church_app/home_cell/model/home_cell_model.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:church_app/utils/notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeCellController with ChangeNotifier {
  Box homeCellBox = Hive.box(kHiveHomeCells);
  Box memberShipBox = Hive.box(kHiveChurchDatabase);

  String cellName = '';
  List cellMembers = [];
  BibleStudyModel homeCellModel = BibleStudyModel();

  Future<void> addHomeCell(BibleStudyModel model) async {
    homeCellBox.add(model.toMap()).then((value) {
      successSnackBar('Home Cell Added successfully');
    });
  }

  deleteHomeCell(index, String cellName) {
    Get.defaultDialog(
      content: Text('Do you want to deleted $cellName'),
      actions: [
        TextButton(
          onPressed: () {
            homeCellBox.deleteAt(index).whenComplete(
              () {
                Get.back();
                successSnackBar('Home Cell Deleted successfully');
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

  updateHomeCellData(key, BibleStudyModel model) {
    homeCellBox.put(key, model.toMap()).whenComplete(() {
      Get.back();
      successSnackBar('Home Cell was updated Successfully');
    });
  }

  getCellMembers(String cellName) {
    cellMembers = memberShipBox.values
        .where((element) =>
            element['Home Cell'].toString().toLowerCase() ==
            cellName.toLowerCase())
        .toList();

    print(cellMembers.length);

    notifyListeners();
  }

  setCellName(name) {
    cellName = name;
    notifyListeners();
  }

  setHomeCell(BibleStudyModel model) {
    homeCellModel = model;
    notifyListeners();
  }
}
