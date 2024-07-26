import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  int selectedNavBar = 0;
  void onNavBarTapped(int index) {
    selectedNavBar = index;
    notifyListeners();
  }
}
