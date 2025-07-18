import 'package:flutter/material.dart';

class TemaController extends ChangeNotifier {
  bool _temaEscuro = false;

  bool get temaEscuro => _temaEscuro;

  ThemeMode get modoAtual => _temaEscuro ? ThemeMode.dark : ThemeMode.light;

  void alternarTema() {
    _temaEscuro = !_temaEscuro;
    notifyListeners();
  }
}
