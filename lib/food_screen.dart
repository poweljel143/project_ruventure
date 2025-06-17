import 'package:flutter/material.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вкусно поесть'),
        backgroundColor: const Color(0xFF131313),
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          'Здесь будут кафе и рестораны',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
