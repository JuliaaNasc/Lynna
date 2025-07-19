import 'dart:async';
import 'package:flutter/material.dart';

class CarrosselController {
  final PageController pageController = PageController();
  final List<String> imagens = [
    'assets/anuncios/anuncio_01.webp',
    'assets/anuncios/anuncio_02.jpg',
    'assets/anuncios/anuncio_03.jpg',
    'assets/imagens/imagem_01.jpg',
    'assets/imagens/imagem_02.jpg',
    'assets/imagens/imagem_03.jpg',
  ];

  int _paginaAtual = 0;
  Timer? _timer;

  /// Inicia o carrossel automático e chama [onPageChanged] sempre que troca de página.
  void iniciarCarrossel(VoidCallback onPageChanged) {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _paginaAtual = (_paginaAtual + 1) % imagens.length;
      pageController.animateToPage(
        _paginaAtual,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      onPageChanged();
    });
  }

  void dispose() {
    _timer?.cancel();
    pageController.dispose();
  }
}
