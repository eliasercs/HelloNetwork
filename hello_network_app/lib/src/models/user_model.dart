import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  bool _userAuth = false;

  Map<String, dynamic> _user = {};

  bool get auth => _userAuth;

  Map<String, dynamic> get authUser => _user;

  void setAuth(bool state) {
    _userAuth = state;
    notifyListeners();
  }

  void setAuthUser(Map<String, dynamic> newUser) {
    _user = newUser;
    notifyListeners();
  }
}
