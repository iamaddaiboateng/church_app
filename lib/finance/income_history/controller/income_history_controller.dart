import 'package:church_app/finance/income_history/model/income_history_model.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:church_app/utils/notifications.dart';
import 'package:hive/hive.dart';

class IncomeHistoryController {
  var box = Hive.box(kHiveIncomeHistoryBox);
  var financeMonthYearBox = Hive.box(kHiveFinanceMonthYearBox);

  addIncome(IncomeHistoryModel model, String date) {
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

  deleteIncome(index) {
    box.deleteAt(index).whenComplete(() {
      successSnackBar('Income Deleted Successfully');
    });
  }

  editIncome(IncomeHistoryModel model, index) {
    box.put(index, model.toMap()).whenComplete(() {
      successSnackBar("Income Added successfully");
    });
  }
}
