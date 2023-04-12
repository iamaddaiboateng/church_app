import 'package:flutter/foundation.dart';

class ExpenditureModel {
  String reason, dateAdded, dateReceived, monthYear;
  double amount;

  ExpenditureModel(
      {@required this.reason,
      @required this.amount,
      @required this.dateAdded,
      @required this.dateReceived,
      @required this.monthYear});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['reason'] = this.reason;
    map['amount'] = this.amount;
    map['dateAdded'] = this.dateAdded;
    map['dateReceived'] = this.dateReceived;
    map['monthYear'] = this.monthYear;

    return map;
  }

  ExpenditureModel.fromMap(Map<dynamic, dynamic> map)
      : this.reason = map['reason'],
        this.amount = map['amount'],
        this.dateAdded = map['dateAdded'],
        this.monthYear = map['monthYear'],
        this.dateReceived = map['dateReceived'];
}
