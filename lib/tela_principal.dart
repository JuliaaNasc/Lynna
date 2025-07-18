import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lynna/controller/tema_controller.dart';
import 'package:provider/provider.dart';

class TelaPrincipalScreen extends StatefulWidget {
  const TelaPrincipalScreen({super.key});

  @override
  State<TelaPrincipalScreen> createState() => _TelaPrincipalScreenState();
}

class _TelaPrincipalScreenState extends State<TelaPrincipalScreen> {
  final TextEditingController _pesquisaController = TextEditingController();
  final PageController _carrosselController = PageController();

  final List<String> _imagensCarrossel = [
    'assets/imagens/imagem_01.jpg',
    'assets/imagens/imagem_02.jpg',
    'assets/imagens/imagem_03.jpg',
  ];

  int _paginaAtual = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        _paginaAtual = (_paginaAtual + 1) % _imagensCarrossel.length;
      });

      _carrosselController.animateToPage(
        _paginaAtual,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pesquisaController.dispose();
    _carrosselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final temaController = Provider.of<TemaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 8),
            Text(
              'Bem-Vindo à Lynna',
              style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch(
                value: temaController.temaEscuro,
                onChanged: (value) {
                  temaController.alternarTema();
                },
              ),
              const SizedBox(width: 12), // espaçamento extra
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCampoDePesquisa(),
            const SizedBox(height: 16),
            _buildCarrosselDeImagens(),
          ],
        ),
      ),
    );
  }

  Widget _buildCampoDePesquisa() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _pesquisaController,
            decoration: const InputDecoration(
              hintText: 'Pesquisar...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            final texto = _pesquisaController.text;
            print('Pesquisando por: $texto');
          },
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
          child: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget _buildCarrosselDeImagens() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _carrosselController,
        itemCount: _imagensCarrossel.length,
        itemBuilder: (context, index) {
          return _buildItemCarrossel(_imagensCarrossel[index]);
        },
      ),
    );
  }

  Widget _buildItemCarrossel(String caminhoImagem) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        caminhoImagem,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
