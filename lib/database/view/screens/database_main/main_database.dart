import 'package:church_app/database/view/widgets/database_main/no_data_found.dart';
import 'package:church_app/database/view/widgets/database_main/show_database.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: Hive.box(kHiveChurchDatabase).listenable(),
      builder: (_, Box box, __) {
        var header = Hive.box(kHiveDatabaseDetails).get(kHiveDatabaseHeader);

        List<Map> dataMap = [];
        box.values.forEach((element) {
          dataMap.add(element);
        });

        return box.isEmpty
            ? NoDatabaseFound()
            : HasDataInDatabasePage(header, dataMap);
      },
    ));
  }
}
