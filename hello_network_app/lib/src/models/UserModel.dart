import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String _id = "1";

  String get currentUser => _id;

  void setUser(id) {
    _id = id;
    notifyListeners();
  }
}
