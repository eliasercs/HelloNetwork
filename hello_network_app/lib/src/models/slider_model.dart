import 'package:flutter/material.dart';

/*
Esta clase actualiza el estado de los dots o la barrita de puntos
en la pantalla de bienvenida.
*/

class SliderModel with ChangeNotifier {
  double _currentPage = 0;

  double get currentPage => _currentPage;

  void setCurrentPage(page) {
    _currentPage = page;
    notifyListeners();
  }
}
