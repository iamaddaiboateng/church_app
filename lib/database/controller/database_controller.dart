import 'dart:io';

import 'package:church_app/database/view/screens/filter_database/filter_database.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:church_app/utils/notifications.dart';
import 'package:csv/csv.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DatabaseController with ChangeNotifier {
  /// The [DatabaseController] is responsible for adding database to the hive database
  /// 1. add bulk data to database
  /// 2. add single database to database

  /// [members] is a list of maps that holds all the members in the csv file convert to a list of maps
  List<Map> members = [];

  /// [header] is the list of string that hold the fields in the database
  List header = [];

  /// [inProgress] is a bool for check progress of a particular progress
  /// it will be linked to the to the view page to help indicate progress
  bool inProgress = false;

  /// [filterField] is the field in the database which will be filtered
  String filterField = '';

  Future<void> getMap(List contact) async {
    /// a method for each item in the csv file into the
    /// the map is then added to the database

    for (var detail in contact) {
      if (contact.indexOf(detail) != 0) {
        Map map = Map.fromIterables(header, detail);
        members.add(map);
        notifyListeners();
      }
    }
  }

  Future pickCSVFile() async {
    /// method for picking csv file
    /// 1. pick file
    /// 2. clear [members] to ensure data is unique
    /// 3. convert csv file to list of lists
    /// 4. assigns first row of csv file as header
    // pick csv file
    final file = OpenFilePicker()
      ..filterSpecification = {'Csv (*.csv)': '*.csv'}
      ..defaultFilterIndex = 0
      ..defaultExtension = 'csv'
      ..title = 'Select File';

    final result = file.getFile();

    if (result != null) {
      members.clear();
      notifyListeners();

      File file = File(result.path);
      var csv = await file.readAsString();

      // convert csv file to list
      List<List<dynamic>> contactsRows = CsvToListConverter().convert(csv);

      // assign first row of csv file to the header
      header = contactsRows.first;

      // pass the new list of from csv file to getMap method to be converted into list of maps
      await getMap(contactsRows);
    }
  }

  addSingleDataToDatabase(
    List<TextEditingController> controllers,
    List header,
  ) {
    List values = [];
    controllers.forEach((element) {
      values.add(element.text);
    });

    Map map = Map.fromIterables(header, values);
    var database = Hive.box(kHiveChurchDatabase);
    database.add(map).whenComplete(() {
      controllers.forEach((element) {
        element.clear();
      });
      successSnackBar('Contact Added Successfully');
    });
  }

  Future addDataToDatabase() async {
    inProgress = true;
    notifyListeners();
    var box = Hive.box(kHiveChurchDatabase);
    var boxDetails = Hive.box(kHiveDatabaseDetails);

    boxDetails.put(kHiveDatabaseHeader, header);
    // print(contactField);

    for (var member in members) {
      box.add(member).whenComplete(() {
        members.remove(member);
        notifyListeners();

        if (members.isEmpty) {
          inProgress = false;
          notifyListeners();
          Get.back();

          Get.snackbar('Done', 'All members were added successfully',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.teal,
              colorText: Colors.white,
              duration: Duration(seconds: 1));
        }
      }).catchError((e) {
        Get.defaultDialog(content: Text(e.toString()));
      });
    }
  }

  setFilterField(String field) {
    /// this method sets the field which will be filtered
    filterField = field;
    notifyListeners();
  }

  filterDatabase(String filter, filterField) {
    final churchBox = Hive.box(kHiveChurchDatabase);
    List churchFilter = [];

    final filteredMembers = churchBox.values.where((element) =>
        element[filterField]
            .toString()
            .toLowerCase()
            .contains(filter.toLowerCase()));

    filteredMembers.forEach((element) {
      churchFilter.add(element);
    });

    print(churchFilter);

    return churchFilter;
  }

  pickQueryField() {
    List header = Hive.box(kHiveDatabaseDetails).get(kHiveDatabaseHeader);

    Get.defaultDialog(
      title: 'Select Filter field',
      content: Container(
        height: 400,
        color: Colors.teal[200],
        child: Scrollbar(
          radius: Radius.circular(0.0),
          isAlwaysShown: true,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                header.length,
                (index) => ListTile(
                  onTap: () {
                    Get.back();
                    Get.to(
                      () => FilterDatabase(
                        header[index],
                      ),
                    );
                  },
                  title: Text(header[index]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
