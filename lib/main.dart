import 'package:flutter/material.dart';
import 'package:lynna/tela_carregamento.dart';
import 'package:lynna/tela_principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const TelaCarregamentoScreen(),
        '/home': (context) => const TelaPrincipalScreen(),
      },
    );
  }
}
