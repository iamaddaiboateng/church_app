import 'package:church_app/home_cell/controller/home_cell_controller.dart';
import 'package:church_app/home_cell/model/home_cell_model.dart';
import 'package:church_app/home_cell/veiw/widgets/add_cell_dialog.dart';
import 'package:church_app/home_cell/veiw/widgets/cell_meeting/add_cell_meeting.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomeCellList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cells',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.dialog(
                              AlertDialog(
                                content: AddHomeCellDialog('add'),
                              ),
                              barrierDismissible: false);
                        },
                        child: Text('Add'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Report'),
                      )
                    ],
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box(kHiveHomeCells).listenable(),
                  builder: (_, Box cellBox, __) {
                    return ListView.builder(
                      itemCount: cellBox.length,
                      itemBuilder: (context, index) {
                        BibleStudyModel model =
                            BibleStudyModel.fromMap(cellBox.getAt(index));

                        return ListTile(
                          onTap: () {
                            final cellController =
                                Provider.of<HomeCellController>(context,
                                    listen: false);

                            cellController.setCellName(model.name);
                            cellController.getCellMembers(model.name);
                          },
                          title: Text(model.name),
                          subtitle: Text(model.leader),
                          leading: IconButton(
                            onPressed: () {
                              var key = cellBox.keyAt(index);
                              print("key is $key");
                              Get.dialog(
                                  AlertDialog(
                                    content: AddHomeCellDialog(
                                      'edit',
                                      model: model,
                                      cellKey: key,
                                    ),
                                  ),
                                  barrierDismissible: false);
                            },
                            icon: Icon(Icons.edit),
                            color: Colors.teal,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.to(() => AddCellMeeting(model.name));
                                },
                                icon: Icon(CupertinoIcons.add_circled),
                                color: Colors.blue,
                              ),
                              IconButton(
                                onPressed: () {
                                  HomeCellController()
                                      .deleteHomeCell(index, model.name);
                                },
                                icon: Icon(CupertinoIcons.delete),
                                color: Colors.red,
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
