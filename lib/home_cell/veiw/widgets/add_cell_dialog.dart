import 'package:church_app/home_cell/controller/home_cell_controller.dart';
import 'package:church_app/home_cell/model/home_cell_model.dart';
import 'package:church_app/utils/genetal_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddHomeCellDialog extends StatefulWidget {
  final String type;
  final BibleStudyModel model;
  final int cellKey;
  AddHomeCellDialog(this.type, {this.model, this.cellKey});

  @override
  _AddHomeCellDialogState createState() => _AddHomeCellDialogState();
}

class _AddHomeCellDialogState extends State<AddHomeCellDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController leaderController = TextEditingController();
  TextEditingController leaderContactController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: widget.type == "edit" ? widget.model.name : '');
    leaderController = TextEditingController(
        text: widget.type == "edit" ? widget.model.leader : '');
    leaderContactController = TextEditingController(
        text: widget.type == "edit" ? widget.model.leaderContact : '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    leaderController.dispose();
    leaderContactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Cell Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Required';
                              } else {
                                return null;
                              }
                            },
                            controller: nameController,
                            decoration:
                                InputDecoration(hintText: 'Enter Cell Name'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Cell leader's Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Required';
                              } else {
                                return null;
                              }
                            },
                            controller: leaderController,
                            decoration: InputDecoration(
                                hintText: "Enter Cell leader's Name"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Leader's Contact",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Required';
                              } else if (!amountString(value)) {
                                return 'Field must contain numbers only';
                              } else {
                                return null;
                              }
                            },
                            controller: leaderContactController,
                            decoration: InputDecoration(
                                hintText: "Enter leader's Contact"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState.validate()) {
                        BibleStudyModel model = BibleStudyModel(
                            name: nameController.text,
                            leader: leaderController.text,
                            leaderContact: leaderContactController.text);

                        print(widget.key);

                        widget.type != "edit"
                            ? HomeCellController()
                                .addHomeCell(model)
                                .whenComplete(() => Get.back())
                            : HomeCellController()
                                .updateHomeCellData(widget.cellKey, model);
                      }
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.teal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 2,
                right: 2,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
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
