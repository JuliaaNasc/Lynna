import 'package:flutter/material.dart';
import 'package:lynna/controller/tema_controller.dart';
import 'package:lynna/tela_principal.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TemaController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final temaController = Provider.of<TemaController>(context);
    return MaterialApp(
      title: 'Lynna',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: Colors.pink, // 👈 Cor principal no modo claro
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,

        colorScheme: ColorScheme.dark(
          primary: Colors.pink, // 👈 Cor principal no modo escuro
        ),
      ),
      themeMode: temaController.modoAtual,
      home: const TelaPrincipalScreen(),
    );
  }
}
