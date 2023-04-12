import 'package:church_app/home_cell/model/cell_meeting_model.dart';
import 'package:church_app/home_cell/utils/cell_strings.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:church_app/utils/notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class DepartmentMeetingController with ChangeNotifier {
  Box departmentBox = Hive.box(kHiveBibleStudyMeetingBox);
  List<BibleStudyMeetingModel> monthlyMeetings = [];

  addDepartmentMeeting(BibleStudyMeetingModel model) {
    departmentBox.add(model.toMap()).whenComplete(
          () => successSnackBar('Department added successfully'),
        );
  }

  filterDepartmentMeetings(String cellName) {
    departmentBox.values
        .where((element) => element[HomeCellString.cellName] == cellName)
        .toList();
  }

  filterMeetingMonths(List<String> months) {
    for (var month in months) {
      var meetings = departmentBox.values
          .where((element) => element[HomeCellString.date]
              .toString()
              .toLowerCase()
              .contains(month))
          .toList();

      meetings.forEach((element) {
        BibleStudyMeetingModel model = BibleStudyMeetingModel.fromMap(element);
        monthlyMeetings.add(model);
      });
    }
    notifyListeners();
  }
}
