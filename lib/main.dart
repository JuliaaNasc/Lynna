import 'package:flutter/material.dart';
import 'package:lynna/controller/tema_controller.dart';
import 'package:lynna/controller/opcoes_controller.dart';
import 'package:lynna/tela_carregamento/splash_screen.dart';
import 'package:lynna/tela_prinicipal/tela_principal.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TemaController()),
        ChangeNotifierProvider(create: (_) => OpcoesController()),
      ],
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
        colorScheme: const ColorScheme.light(primary: Colors.pink),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(primary: Colors.pink),
      ),
      themeMode: temaController.modoAtual,
      home: const SplashScreen(), // 👈 tela de carregamento
    );
  }
}
