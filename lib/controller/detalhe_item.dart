import 'package:flutter/material.dart';

class OpcaoDetalheItem extends StatelessWidget {
  final String titulo;
  final String descricao;
  final VoidCallback onTap;

  const OpcaoDetalheItem({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.place, color: Colors.pink),
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(descricao),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
