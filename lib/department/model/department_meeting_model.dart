import 'package:church_app/home_cell/utils/cell_strings.dart';

class DepartmentMeetingModel {
  String cellName, date, monthYear, year;
  int males, females, children, elders, deacons, deaconesses, totalMember;
  double offering;
  DateTime rawDate;

  DepartmentMeetingModel(
      {required this.cellName,
      required this.date,
      required this.males,
      required this.females,
      required this.children,
      required this.elders,
      required this.deacons,
      required this.deaconesses,
      required this.offering,
      required this.rawDate,
      required this.year,
      required this.monthYear,
      required this.totalMember});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();

    map[HomeCellString.cellName] = this.cellName;
    map[HomeCellString.date] = this.date;
    map[HomeCellString.rawDate] = this.rawDate;
    map[HomeCellString.males] = this.males;
    map[HomeCellString.females] = this.females;
    map[HomeCellString.children] = this.children;
    map[HomeCellString.elders] = this.elders;
    map[HomeCellString.deacons] = this.deacons;
    map[HomeCellString.deaconess] = this.deaconesses;
    map[HomeCellString.offering] = this.offering;
    map[HomeCellString.monthYear] = this.monthYear;
    map[HomeCellString.year] = this.year;
    map[HomeCellString.totalMembers] = this.totalMember;

    return map;
  }

  DepartmentMeetingModel.fromMap(Map<String, dynamic> map)
      : this.cellName = map[HomeCellString.cellName],
        this.date = map[HomeCellString.date],
        this.rawDate = map[HomeCellString.rawDate],
        this.males = map[HomeCellString.males],
        this.females = map[HomeCellString.females],
        this.children = map[HomeCellString.children],
        this.elders = map[HomeCellString.elders],
        this.deacons = map[HomeCellString.deacons],
        this.deaconesses = map[HomeCellString.deaconess],
        this.totalMember = map[HomeCellString.totalMembers],
        this.monthYear = map[HomeCellString.monthYear],
        this.year = map[HomeCellString.year],
        this.offering = map[HomeCellString.offering];
}
