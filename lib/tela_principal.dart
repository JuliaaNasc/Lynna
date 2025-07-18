import 'package:flutter/material.dart';

class TelaPrincipalScreen extends StatelessWidget {
  const TelaPrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController pesquisaController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.location_on),
            SizedBox(width: 8),
            Text('Lynna'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    // Aqui você pode tratar a busca
                    print('Pesquisando por: $textoDigitado');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
