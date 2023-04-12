import 'package:flutter/material.dart';
import 'package:get/get.dart';

successSnackBar(String message) {
  Get.snackbar('Successful', message,
      colorText: Colors.white,
      backgroundColor: Colors.green[700],
      snackPosition: SnackPosition.BOTTOM);
}
