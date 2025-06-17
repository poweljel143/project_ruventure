import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        backgroundColor: const Color(0xFF131313),
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          'Здесь будут настройки приложения',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
