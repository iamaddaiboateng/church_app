import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePageController extends ChangeNotifier {
  Widget currentWidget;
  String page;

  changePage(String newPage) {
    page = newPage;
    notifyListeners();
  }
}
