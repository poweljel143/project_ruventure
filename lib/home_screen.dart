import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: SingleChildScrollView(
          child: MyLayout(),
        ),
      ),
    );
  }
}

class MyLayout extends StatelessWidget {
  const MyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image 3
        Positioned(
          left: 24,
          top: 460,
          child: Container(
            width: 199,
            height: 197,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/image_3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Image 2
        Positioned(
          left: 24,
          top: 115,
          child: Container(
            width: 199,
            height: 267,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/image_2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Image 1
        Positioned(
          left: 101,
          top: 308,
          child: Container(
            width: 287,
            height: 196,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/image_1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Text View
        Positioned(
          left: 243,
          top: 205,
          child: SizedBox(
            width: 114,
            height: 70,
            child: RichText(
              text: TextSpan(
                text: 'Куда сходить\nв Томске?',
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 0.24,
                  color: const Color(0xFFF9F9FC),
                  height: 1.0,
                  fontFeatures: const [
                    FontFeature.proportionalFigures(),
                    FontFeature.liningFigures(),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Line MD Clo
        Positioned(
          left: 18,
          top: 66,
          child: Container(
            width: 31,
            height: 32,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Group 7
        Positioned(
          left: 24,
          top: 1010,
          child: Container(
            width: 165,
            height: 198,
          ),
        ),

        // Group 9
        Positioned(
          left: 24,
          top: 1238,
          child: Container(
            width: 165,
            height: 198,
          ),
        ),

        // Group 6
        Positioned(
          left: 223,
          top: 782,
          child: Container(
            width: 165,
            height: 198,
          ),
        ),

        // Group 11
        Positioned(
          left: 24,
          top: 782,
          child: Container(
            width: 165,
            height: 198,
          ),
        ),

        // Image 6
        Positioned(
          left: 27,
          top: 785,
          child: Container(
            width: 156,
            height: 147,
          ),
        ),

        // Group 8
        Positioned(
          left: 223,
          top: 1010,
          child: Container(
            width: 165,
            height: 198,
          ),
        ),

        // Group 10
        Positioned(
          left: 223,
          top: 1238,
          child: Container(
            width: 165,
            height: 198,
          ),
        ),

        // Group 36699
        Positioned(
          left: 24,
          top: 710,
          child: Container(
            width: 331,
            height: 36,
          ),
        ),
      ],
    );
  }
}