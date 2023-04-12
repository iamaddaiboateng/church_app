import 'dart:io';

import 'package:church_app/bible_studies/controller/bible-study_controller.dart';
import 'package:church_app/finance/monthly_overview/controller/finance_monthly_controller.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:church_app/utils/shift_fix.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathDirectory;
import 'package:provider/provider.dart';

import 'file:///E:/projects/church_app/lib/home_cell/controller/home_cell_controller.dart';

import 'database/controller/database_controller.dart';
import 'department/controller/department_controller.dart';
import 'home/view/home_page.dart';

main() async {
  final path = await pathDirectory.getApplicationDocumentsDirectory();
  final folderName = 'Church App';
  final folderPath =
      Directory(path.path + '\\' + folderName + '\\' + 'Database');
  Hive.init(folderPath.path);

  await Hive.openBox(kHiveChurchDatabase);
  await Hive.openBox(kHiveDatabaseDetails);
  await Hive.openBox(kHiveIncomeStreamBox);
  await Hive.openBox(kHiveIncomeHistoryBox);
  await Hive.openBox(kHiveExpenditureBox);
  await Hive.openBox(kHiveHomeCells);
  await Hive.openBox(kHiveCellMeetings);
  await Hive.openBox(kHiveFinanceMonthYearBox);
  await Hive.openBox(kHiveBibleStudyBox);
  await Hive.openBox(kHiveBibleStudyMeetingBox);
  await Hive.openBox(kHiveDepartmentBox);
  await Hive.openBox(kHiveDepartmentMeetingBox);

  runApp(
    ShiftRightFixer(
      child: ChurchApp(),
    ),
  );
}

class ChurchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseController>(
          create: (context) => DatabaseController(),
        ),
        ChangeNotifierProvider<HomeCellController>(
          create: (context) => HomeCellController(),
        ),
        ChangeNotifierProvider<BibleStudyController>(
            create: (context) => BibleStudyController()),
        ChangeNotifierProvider<FinanceMonthlyController>(
          create: (context) => FinanceMonthlyController(),
        ),
        ChangeNotifierProvider<DepartmentController>(
          create: (context) => DepartmentController(),
        )
      ],
      child: GetMaterialApp(
        title: 'Church App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: HomePage(),
      ),
    );
  }
}
