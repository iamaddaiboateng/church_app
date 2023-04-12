import 'package:church_app/home_cell/model/cell_meeting_model.dart';
import 'package:church_app/home_cell/utils/cell_strings.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:church_app/utils/notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class CellMeetingController with ChangeNotifier {
  Box cellMeetingBox = Hive.box(kHiveCellMeetings);
  List<BibleStudyMeetingModel> monthlyMeetings = [];

  addCellMeeting(BibleStudyMeetingModel model) {
    cellMeetingBox.add(model.toMap()).whenComplete(
          () => successSnackBar('Cell Meeting added successfully'),
        );
  }

  filterCellMeetings(String cellName) {
    cellMeetingBox.values
        .where((element) => element[HomeCellString.cellName] == cellName)
        .toList();
  }

  filterMeetingMonths(List<String> months) {
    for (var month in months) {
      var meetings = cellMeetingBox.values
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
