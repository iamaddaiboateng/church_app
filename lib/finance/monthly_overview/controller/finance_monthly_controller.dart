import 'package:church_app/finance/expenditure_histotry/model/expenditure_model.dart';
import 'package:church_app/finance/income_history/model/income_history_model.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class FinanceMonthlyController with ChangeNotifier {
  final financeMonthBox = Hive.box(kHiveFinanceMonthYearBox);
  final incomeBox = Hive.box(kHiveIncomeHistoryBox);
  final expenditureBox = Hive.box(kHiveExpenditureBox);

  // list of map contain the month selected, total income and total expenditure
  List<Map<String, dynamic>> filteredMaps = [];
  Set<String> incomeSource = {};
  Set<String> incomeOutlet = {};
  Set<String> months = {};

  double totalIncome = 0.0;
  double totalExpenditure = 0.0;

  // add value to months
  addValueToMonths(String month) {
    if (!months.contains(month)) {
      months.add(month);
      filterFinance(months);
    } else {
      months.remove(month);
      filterFinance(months);
    }
    print(months);
    notifyListeners();
  }

  clearMonthsSet() {
    months.clear();
    notifyListeners();
  }

  setCurrentMonth() {}

  // create method to filter income the expenditure boxes

  filterFinance(Set<String> months) {
    List<Map<String, dynamic>> maps = [];
    // list of all incomes within select months

    Set<String> incomeSources = {};
    Set<String> incomeOutlets = {};

    List incomeMonth = [];

    // list of all expenditure within select months
    List expenditureMonth = [];

    // run a for loop to:
    // 1. query database for selected months
    // 2. calculate the total income and expenditure for all selected months
    // 3. create a map that stores to name of the month, total income and expenditure

    for (var month in months) {
      // total income for each month
      double monthlyIncome = 0.0;

      // total expenditure for each month
      double monthlyExpenditure = 0.0;

      // query for all incomes that matches a particular month in the list of months
      List incomes = incomeBox.values
          .where((element) => element['monthYear'] == month)
          .toList();

      incomes.forEach((element) {
        IncomeHistoryModel model = IncomeHistoryModel.fromMap(element);
        incomeSources.add(model.incomeType);

        monthlyIncome += element['amount'];
      });

      // query for all expenditure that match a particular month in the list of months
      List expenses = expenditureBox.values
          .where((element) => element['monthYear'] == month)
          .toList();

      // calculate the total income for the particular month
      expenses.forEach((element) {
        ExpenditureModel model = ExpenditureModel.fromMap(element);
        monthlyExpenditure += element['amount'];
        incomeOutlets.add(model.reason);
      });

      // create map that holds month, income and expenditure
      Map<String, dynamic> monthlyMap = {
        'month': month,
        'income': monthlyIncome,
        'expenditure': monthlyExpenditure,
        // 'source': incomeSource,
        // 'outlet': incomeOutlet
      };

      // add map to the list of maps
      maps.add(monthlyMap);

      filteredMaps = maps;
      // incomeSources.clear();
      // incomeOutlets.clear();
      incomeSource = incomeSources;
      incomeOutlet = incomeOutlets;

      // add all database fields within the select months to the general list of income and expenditure
      incomeMonth.addAll(incomes);
      expenditureMonth.addAll(expenses);
    }

    // calculate total income and expenditure

    totalExpenditure = 0.0;
    totalIncome = 0.0;

    maps.forEach((element) {
      totalIncome += element['income'];
      totalExpenditure += element['expenditure'];
    });

    print('incomeMonth ${incomeMonth.length}');
    print('expenditureMonth ${expenditureMonth.length}');
    print('monthly map $maps');
    print('filtered map $filteredMaps');
    print('total expenditure $totalExpenditure');
    print('total income $totalIncome');

    print(months);
  }
}
