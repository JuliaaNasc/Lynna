import 'package:flutter/material.dart';

class DetalheScreen extends StatelessWidget {
  final String titulo;
  final String descricao;

  const DetalheScreen({
    super.key,
    required this.titulo,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A Lynna está $titulo'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            descricao,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
