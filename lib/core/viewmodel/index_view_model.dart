import 'package:flutter/material.dart';

class NavigationViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int? _argument;
  int get currentIndex => _currentIndex;
  int? get argument => _argument;
  void setCurrentIndex(int index) {
    _currentIndex = index;
    print("Current index Stack: $_currentIndex");
    notifyListeners();
  }
  void setArgument(int argument) {
    _argument = argument;
    print("Argument set: $_argument");
    notifyListeners();
  }

  int? getArgument() {
    final int? arg = _argument;
    _argument = null; // Clear the argument after retrieving
    print("Argument retrieved: $arg");
    return arg;
  }
}
