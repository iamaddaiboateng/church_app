import 'package:church_app/database/controller/database_controller.dart';
import 'package:church_app/database/core/paginated_extra_data.dart';
import 'package:church_app/database/core/row_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddBulkData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseController>(
      builder: (_, data, __) => data.members.isEmpty
          ? Scaffold(
              body: Center(
                child: Container(
                  width: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          'No Database file selected. Please Select a database file'),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            data.pickCSVFile();
                          },
                          child: Text('Choose File'))
                    ],
                  ),
                ),
              ),
            )
          : Scaffold(
              body: PaginatedDataTable(
                header: Text('Database'),
                actions: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Get.back();
                      }),
                  IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        data.pickCSVFile();
                      }),
                  IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        data.addDataToDatabase();
                      })
                ],
                columns: headerToDataTable(data.header),
                source: RowData(data.members, data.header),
              ),
            ),
    );
  }
}
