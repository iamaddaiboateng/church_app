import 'package:flutter/foundation.dart';

class IncomeHistoryModel {
  String incomeType, dateAdded, dateReceived, monthYear;
  double amount;
  IncomeHistoryModel(
      {@required this.incomeType,
      @required this.amount,
      @required this.dateAdded,
      @required this.dateReceived,
      @required this.monthYear});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['incomeType'] = this.incomeType;
    map['amount'] = this.amount;
    map['dateAdded'] = this.dateAdded;
    map['monthYear'] = this.monthYear;
    map['dateReceived'] = this.dateReceived;

    return map;
  }

  IncomeHistoryModel.fromMap(Map<dynamic, dynamic> map)
      : this.incomeType = map['incomeType'],
        this.amount = map['amount'],
        this.dateAdded = map['dateAdded'],
        this.monthYear = map['monthYear'],
        this.dateReceived = map['dateReceived'];
}
