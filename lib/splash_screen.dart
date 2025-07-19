import 'package:flutter/material.dart';
import 'package:lynna/tela_prinicipal/tela_principal.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const TelaPrincipalScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/logo_lynna.png', width: 250, height: 250),
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.pink),
          ],
        ),
      ),
    );
  }
}
