import 'package:flutter/material.dart';
import 'package:hello_network_app/src/utils/api.dart';

class TaskModel extends ChangeNotifier {
  Map<String, dynamic> _tasks = {};

  Map<String, dynamic> get tasks => _tasks;

  void setTasks(Map<String, dynamic> data) {
    _tasks = data;
    notifyListeners();
  }
}
