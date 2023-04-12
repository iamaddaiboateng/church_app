import 'package:church_app/database/controller/database_controller.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AddSingleDataToDatabase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List header = Hive.box(kHiveDatabaseDetails).get(kHiveDatabaseHeader);
    List<TextEditingController> controllers =
        List.generate(header.length, (index) => TextEditingController());

    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: Stack(
        children: [
          Scrollbar(
            isAlwaysShown: true,
            thickness: 10,
            hoverThickness: 10,
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: 500,
                  child: Column(
                    children: List.generate(header.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  header[index],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Divider(),
                                TextField(
                                  controller: controllers[index],
                                  decoration: InputDecoration(
                                      hintText: 'Enter ${header[index]}'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Row(
              children: [
                FloatingActionButton(
                  mini: true,
                  heroTag: 'add',
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  width: 10.0,
                ),
                FloatingActionButton(
                  mini: true,
                  heroTag: 'save',
                  child: Icon(Icons.save),
                  onPressed: () {
                    DatabaseController()
                        .addSingleDataToDatabase(controllers, header);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
