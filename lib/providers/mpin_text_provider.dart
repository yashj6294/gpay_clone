import 'package:flutter/material.dart';

class MpinTextProvider extends ChangeNotifier {
  String _mpin = "";
  String get mpin => _mpin;
  void setMpin(value) {
    _mpin = value;
    notifyListeners();
  }
}
