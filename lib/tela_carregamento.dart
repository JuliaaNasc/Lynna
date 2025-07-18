import 'package:flutter/material.dart';

class TelaCarregamentoScreen extends StatefulWidget {
  const TelaCarregamentoScreen({super.key});

  @override
  State<TelaCarregamentoScreen> createState() => _TelaCarregamentoScreenState();
}

class _TelaCarregamentoScreenState extends State<TelaCarregamentoScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            const Text(
              'Lynna está carregando...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
