import 'package:flutter/material.dart';

class NearbyPlacesScreen extends StatelessWidget {
  const NearbyPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Места рядом'),
        backgroundColor: const Color(0xFF131313),
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          'Здесь будут места рядом с вами',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
