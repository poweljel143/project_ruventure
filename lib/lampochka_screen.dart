import 'package:flutter/material.dart';

class LampochkaDetailScreen extends StatelessWidget {
  const LampochkaDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лампочка'),
        backgroundColor: const Color(0xFF000000),
      ),
      backgroundColor: const Color(0xFF000000),
      body: const Center(
        child: Text(
          'Добро пожаловать в гастрохолл "Лампочка"!',
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
