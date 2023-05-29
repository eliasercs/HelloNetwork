import 'package:flutter/material.dart';

class TableroModel extends ChangeNotifier {
  final List<String> _tablero = [];

  List<String> get tableroSprint => _tablero;

  void appendTablero(value) {
    _tablero.add(value);
    notifyListeners();
  }
}
