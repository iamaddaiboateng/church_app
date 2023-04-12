import 'package:church_app/finance/income_stream/controller/income_stream_controller.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class IncomeStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Income Stream',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box(kHiveIncomeStreamBox).listenable(),
                  builder: (_, Box box, __) {
                    var dataLength = box.length >= 5
                        ? box.values.toList().getRange(0, 5).length
                        : box.length;
                    print(dataLength);

                    return box.isEmpty
                        ? Center(
                            child: Text('No Income Stream Added'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: dataLength,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(box.getAt(index)),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete_forever_outlined),
                                  color: Colors.red,
                                  onPressed: () {
                                    IncomeStreamController()
                                        .deletedIncomeDialog(index);
                                  },
                                ),
                              );
                            });
                  },
                ),
              ),
              Divider(),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  child: Text('Add'),
                  onPressed: () {
                    IncomeStreamController().addIncomeStreamDialog();
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
