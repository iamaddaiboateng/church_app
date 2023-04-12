import 'package:flutter/material.dart';

class MaterialTextField extends StatelessWidget {
  final TextEditingController controller;
  final String info;
  Function? validation;
  MaterialTextField(
      {required this.controller,
      required this.info,
      required String? this.validation(String? value)});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "$info",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(),
            TextFormField(
              validator: validation,
              controller: controller,
              decoration: InputDecoration(hintText: "Enter $info"),
            ),
          ],
        ),
      ),
    );
  }
}
