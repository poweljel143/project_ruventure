import 'package:flutter/material.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Маршруты'),
        backgroundColor: const Color(0xFF131313),
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          'Здесь будут маршруты',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
