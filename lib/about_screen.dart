import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О приложении'),
        backgroundColor: const Color(0xFF131313),
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          'Информация о приложении',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
