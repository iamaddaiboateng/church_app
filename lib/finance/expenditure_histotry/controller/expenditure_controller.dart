import 'package:church_app/finance/expenditure_histotry/model/expenditure_model.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:church_app/utils/notifications.dart';
import 'package:hive/hive.dart';

class ExpenditureController {
  var box = Hive.box(kHiveExpenditureBox);
  var financeMonthYearBox = Hive.box(kHiveFinanceMonthYearBox);

  addExpenditure(ExpenditureModel model, String date) {
    box.add(model.toMap()).whenComplete(() {
      successSnackBar("Income Added successfully");

      List dateList = financeMonthYearBox.values.toList();

      if (!dateList.contains(date)) {
        financeMonthYearBox.add(date).whenComplete(() => print('date added'));
      } else {
        print(financeMonthYearBox.values);
        print('Date already exist');
      }
    });
  }

  deleteExpenditure(index) {
    box.deleteAt(index).whenComplete(() {
      successSnackBar('Income Deleted Successfully');
    });
  }

  editExpenditure(ExpenditureModel model, index) {
    box.put(index, model.toMap()).whenComplete(() {
      successSnackBar("Income Added successfully");
    });
  }
}
