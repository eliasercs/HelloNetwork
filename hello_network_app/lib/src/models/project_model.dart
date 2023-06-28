import 'package:flutter/material.dart';
import 'package:hello_network_app/src/models/tablero_model.dart';

class ProjectModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _projects_names = [];

  List<Map<String, dynamic>> get projects => _projects_names;

  void addProject(project) {
    _projects_names.add(project);
    notifyListeners();
  }
}

class ProjectSelected extends ChangeNotifier {
  Map<String, dynamic> _project_selected = {};

  Map<String, dynamic> get project_selected => _project_selected;

  void selectProject(project) {
    _project_selected = project;
    notifyListeners();
  }
}
