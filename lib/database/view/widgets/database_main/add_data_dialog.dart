import 'package:church_app/database/view/screens/add_data/add_bulk_data.dart';
import 'package:church_app/database/view/screens/add_data/add_single_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

addDataDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                  onPressed: () {
                    Get.to(() => AddSingleDataToDatabase());
                  },
                  child: Text('Add Single Member')),
              SizedBox(
                height: 10.0,
              ),
              OutlinedButton(
                  onPressed: () {
                    Get.to(() => AddBulkData());
                  },
                  child: Text('Add Bulk list'))
            ],
          ),
        );
      });
}
