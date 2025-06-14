import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'slider_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          // Логотип с круглым свечением
          SizedBox(
            width: 218,
            height: 218,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Круглое свечение
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFADFFDA).withOpacity(0.15),
                          blurRadius: 65,
                          spreadRadius: 15,
                        ),
                        BoxShadow(
                          color: const Color(0xFF0212FE).withOpacity(0.1),
                          blurRadius: 55,
                          spreadRadius: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                // Логотип
                Image.asset(
                  'assets/image/logo.png',
                  width: 218,
                  height: 118,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          const Spacer(),
          // Нижний блок (без изменений)
          Container(
            width: double.infinity,
            height: 394,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF131646), Color(0xFF242EC0)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
              ),
            ),
            child: Stack( // Используем Stack вместо Column для точного позиционирования
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Color(0xFF0212FF), // Синий
                              Color(0xFFADFFDA), // Светло-зеленый
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: const Text(
                          "ruventure -",
                          style: TextStyle(
                            fontFamily: 'TT Norms Pro',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 0.01,
                            height: 0.75,
                            color: Colors.white, // Важно: должен быть белый для работы градиента
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "лучшие места твоего города \nв одном приложении",
                        style: TextStyle(
                          fontFamily: 'TT Norms Pro',
                          color: Color(0xFFADFFDA),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.01,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 75),
                    ],
                  ),
                ),
                // Ползунок, прижатый к правому краю
                Positioned(
                  right: 0, // Прижимаем к правому краю
                  bottom: 150, // Отступ снизу как в Padding
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SliderScreen()),
                      );
                    },
                    child: Container(
                      height: 75,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color(0xFF030E49),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          bottomLeft: Radius.circular(32),
                        ),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors: [
                                  Color(0xFFADFFDA),
                                  Color(0xFF0212FF),
                                  Color(0xFFADFFDA),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 55,
                                height: 55,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF030E49),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.blueAccent,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

