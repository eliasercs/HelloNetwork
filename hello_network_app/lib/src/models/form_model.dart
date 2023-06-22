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

Map<String, dynamic> _defaultAddTaskError() {
  return {
    "titleTask": <String>[],
    "dateTask": <String>[],
    "descriptionTask": <String>[],
    "statusTask": <String>[]
  };
}

class UserFormModel extends ChangeNotifier {
  Map<String, dynamic> _user = {};

  dynamic value(key) => _user[key];

  Map<String, dynamic> get newUser => _user;

  bool issetProperty(String key) => _user[key] != null ? true : false;

  void setProperty(String key, dynamic value) {
    _user[key] = value;
    notifyListeners();
  }

  void setNewUser(data) {
    _user = data;
    notifyListeners();
  }

  void reset() {
    _user = {};
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

  void deleteError() {
    _error = {};
    notifyListeners();
  }

  void setError() {
    if (_stateErrorForm == "signup") {
      _error = _defaultSignUpError();
    } else if (_stateErrorForm == "addTask") {
      _error = _defaultAddTaskError();
    } else {
      _error = _defaultLogInError();
    }
    notifyListeners();
  }
}
