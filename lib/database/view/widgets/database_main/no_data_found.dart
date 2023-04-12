import 'package:church_app/database/view/widgets/database_main/add_data_dialog.dart';
import 'package:church_app/utils/genetal_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDatabaseFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Database is empty',
                style: Theme.of(context).textTheme.headline4!.merge(
                      TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(kDatabaseEmpty),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  addDataDialog(context);
                },
                child: Text("Add Database"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
