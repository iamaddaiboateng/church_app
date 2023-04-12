import 'package:church_app/bible_studies/controller/bible-study_controller.dart';
import 'package:church_app/bible_studies/veiw/widgets/bible_study_dialog.dart';
import 'package:church_app/home_cell/model/home_cell_model.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'cell_meeting/bible_study_meeting.dart';

class BibleStudiesList extends StatelessWidget {
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
                    'Bible Study Groups',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.dialog(
                              AlertDialog(
                                content: BibleStudyDialog('add'),
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
                  valueListenable: Hive.box(kHiveBibleStudyBox).listenable(),
                  builder: (_, Box bibleBox, __) {
                    return ListView.builder(
                      itemCount: bibleBox.length,
                      itemBuilder: (context, index) {
                        BibleStudyModel model =
                            BibleStudyModel.fromMap(bibleBox.getAt(index));

                        return ListTile(
                          onTap: () {
                            final cellController =
                                Provider.of<BibleStudyController>(context,
                                    listen: false);

                            cellController.setCellName(model.name);
                            cellController.getCellMembers(model.name);
                          },
                          title: Text(model.name),
                          subtitle: Text(model.leader),
                          leading: IconButton(
                            onPressed: () {
                              var key = bibleBox.keyAt(index);
                              print("key is $key");
                              Get.dialog(
                                  AlertDialog(
                                    content: BibleStudyDialog(
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
                                  Get.to(
                                      () => AddBibleStudyMeeting(model.name));
                                },
                                icon: Icon(CupertinoIcons.add_circled),
                                color: Colors.blue,
                              ),
                              IconButton(
                                onPressed: () {
                                  BibleStudyController()
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
