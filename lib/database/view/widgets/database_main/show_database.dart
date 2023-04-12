import 'package:church_app/database/controller/database_controller.dart';
import 'package:church_app/database/core/paginated_extra_data.dart';
import 'package:church_app/database/core/row_data.dart';
import 'package:church_app/database/view/screens/add_data/add_single_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HasDataInDatabasePage extends StatelessWidget {
  final List header;
  final List<Map> box;

  HasDataInDatabasePage(this.header, this.box);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[100]!.withOpacity(0.5),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: PaginatedDataTable(
              rowsPerPage: 13,
              header: Text('Database'),
              actions: [
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Get.to(() => AddSingleDataToDatabase());
                    }),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      DatabaseController().pickQueryField();
                    }),
              ],
              columns: headerToDataTable(header),
              source: RowData(box, header),
            ),
          ),
        ));
  }
}
