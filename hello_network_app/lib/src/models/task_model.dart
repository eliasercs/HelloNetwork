import 'package:flutter/material.dart';

class TaskModel extends ChangeNotifier {
  Map<String, dynamic> _tasks = {};
  Map<String, dynamic> _taskForm = {
    "title": "",
    "description": "",
    "date": "",
    "status": ""
  };

  Map<String, dynamic> get tasks => _tasks;
  Map<String, dynamic> get taskForm => _taskForm;

  void setTasks(Map<String, dynamic> data) {
    _tasks = data;
    notifyListeners();
  }

  void setTaskForm(String key, dynamic data) {
    _taskForm[key] = data;
    notifyListeners();
  }

  void resetTaskForm() {
    _taskForm = {"title": "", "description": "", "date": "", "status": ""};
    notifyListeners();
  }
}
