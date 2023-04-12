import 'package:church_app/database/core/paginated_extra_data.dart';
import 'package:church_app/database/core/row_data.dart';
import 'package:church_app/department/controller/department_controller.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class DepartmentMembers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Box box = Hive.box(kHiveDatabaseDetails);
    var header = box.get(kHiveDatabaseHeader);

    return Consumer<DepartmentController>(
      builder: (_, bible, __) {
        print(bible.departmentMembers);

        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: PaginatedDataTable(
              header: Text(bible.departmentName),
              columns: headerToDataTable(box.get(kHiveDatabaseHeader)),
              source: RowData(bible.departmentMembers, header),
            ),
          ),
        );
      },
    );
  }
}
