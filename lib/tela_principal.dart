import 'dart:async';
import 'package:flutter/material.dart';

class TelaPrincipalScreen extends StatefulWidget {
  const TelaPrincipalScreen({super.key});

  @override
  State<TelaPrincipalScreen> createState() => _TelaPrincipalScreenState();
}

class _TelaPrincipalScreenState extends State<TelaPrincipalScreen> {
  final TextEditingController pesquisaController = TextEditingController();
  final PageController _pageController = PageController();
  int _paginaAtual = 0;

  final List<String> imagens = [
    'assets/imagens/imagem_01.jpg',
    'assets/imagens/imagem_02.jpg',
    'assets/imagens/imagem_03.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_paginaAtual < imagens.length - 1) {
        _paginaAtual++;
      } else {
        _paginaAtual = 0;
      }
      _pageController.animateToPage(
        _paginaAtual,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    pesquisaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.location_on),
            SizedBox(width: 8),
            Text('Seja Bem-Vindo a Lynna'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de pesquisa
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: pesquisaController,
                    decoration: const InputDecoration(
                      hintText: 'Pesquisar...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final textoDigitado = pesquisaController.text;
                    print('Pesquisando por: $textoDigitado');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Carrossel automático
            SizedBox(
              height: 180,
              child: PageView.builder(
                controller: _pageController,
                itemCount: imagens.length,
                itemBuilder: (context, index) {
                  return _buildCarrosselItem(imagens[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para imagem do carrossel
  Widget _buildCarrosselItem(String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
