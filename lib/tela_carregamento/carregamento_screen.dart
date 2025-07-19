import 'package:flutter/material.dart';
import 'package:lynna/tela_prinicipal/principal_screen.dart';

class CarregamentoScreen extends StatefulWidget {
  const CarregamentoScreen({super.key});

  @override
  State<CarregamentoScreen> createState() => _CarregamentoScreenState();
}

class _CarregamentoScreenState extends State<CarregamentoScreen> {
  double _opacity = 0;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();

    // Inicia animação de opacidade e escala
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1;
        _scale = 1.0;
      });
    });

    // Vai para a tela principal após 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const PrincipalScreen()),
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
            AnimatedOpacity(
              duration: const Duration(milliseconds: 800),
              opacity: _opacity,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.8, end: _scale),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/logo/logo_lynna.png',
                  width: 250,
                  height: 250,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const CircularProgressIndicator(color: Colors.pink),
          ],
        ),
      ),
    );
  }
}
