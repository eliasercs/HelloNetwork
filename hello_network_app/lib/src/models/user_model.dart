import 'package:flutter/material.dart';
import 'package:hello_network_app/src/utils/api.dart';

class UserModel extends ChangeNotifier {
  bool _userAuth = false;

  Map<String, dynamic> _user = {};

  bool get auth => _userAuth;

  Map<String, dynamic> get authUser => _user;

  void initUserAuth() async {
    final data = await ApiServices().getUserAuth();
    _user = data;
    notifyListeners();
  }

  void setAuth(bool state) {
    _userAuth = state;
    notifyListeners();
  }

  void setAuthUser(Map<String, dynamic> newUser) {
    _user = newUser;
    notifyListeners();
  }
}
