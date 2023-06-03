import "package:flutter/material.dart";

Map<String, dynamic> _defaultSignUpError() {
  return {
    "name": <String>[],
    "lastname": <String>[],
    "email": <String>[],
    "password": <String>[],
    "repeat_password": <String>[]
  };
}

Map<String, dynamic> _defaultLogInError() {
  return {"email": <String>[], "password": <String>[]};
}

class NewUserModel extends ChangeNotifier {
  Map<String, dynamic> _new_user = {};

  dynamic value(key) => _new_user[key];

  Map<String, dynamic> get newUser => _new_user;

  void setProperty(String key, dynamic value) {
    _new_user[key] = value;
    notifyListeners();
  }

  void setNewUser(data) {
    _new_user = data;
    notifyListeners();
  }
}

class ErrorModel extends ChangeNotifier {
  String _stateErrorForm = "";

  Map<String, dynamic> _error = {};

  String get status => _stateErrorForm;

  void setStateErrorForm(String value) {
    _stateErrorForm = value;
    notifyListeners();
  }

  List getError(String key) => _error[key];

  dynamic get error => _error;

  void addError(String key, dynamic value) {
    _error[key] = value;
    notifyListeners();
  }

  void setError() {
    if (_stateErrorForm == "signup") {
      _error = _defaultSignUpError();
    } else {
      _error = _defaultLogInError();
    }
    notifyListeners();
  }
}
