import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'slider_screen.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Настройка прозрачного системного UI
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Инициализация Supabase (без authFlowType)
  try {
    await Supabase.initialize(
      url: 'https://pabqxlekiybzgzezansw.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBhYnF4bGVraXliemd6ZXphbnN3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAzNTE3NjcsImV4cCI6MjA2NTkyNzc2N30.hNmgsaoYB64LWjdjrJvevJQB88izLKYAAxL6CogN9J4',
      debug: true,
    );
    print('✅ Supabase инициализирован');
  } catch (e) {
    print('❌ Ошибка Supabase: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'TT Norms Pro',
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/slider': (context) => const SliderScreen(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Проверка авторизации при загрузке
    _checkAuth(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          // Анимированное лого с градиентным свечением
          _buildAnimatedLogo(),
          const Spacer(),
          // Градиентный нижний блок с текстом и кнопкой
          _buildBottomAuthBlock(context),
        ],
      ),
    );
  }

  void _checkAuth(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    final route = session != null ? '/slider' : '/login';
    
    Future.delayed(Duration(seconds: session != null ? 0 : 3), () {
      Navigator.pushReplacementNamed(context, route);
    });
  }

  Widget _buildAnimatedLogo() {
    return SizedBox(
      width: 218,
      height: 218,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Свечение
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
    );
  }

  Widget _buildBottomAuthBlock(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 394,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF131646), Color(0xFF242EC0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Градиентный текст
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF0212FF), Color(0xFFADFFDA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    "ruventure -",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      height: 0.75,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "лучшие места твоего города \nв одном приложении",
                  style: TextStyle(
                    color: Color(0xFFADFFDA),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
          // Кнопка перехода
          Positioned(
            right: 0,
            bottom: 150,
            child: _buildAuthButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/slider'),
      child: Container(
        height: 75,
        width: 150,
        decoration: const BoxDecoration(
          color: Color(0xFF030E49),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(left: 4),
              decoration: const BoxDecoration(
                gradient: SweepGradient(
                  colors: [
                    Color(0xFFADFFDA),
                    Color(0xFF0212FF),
                    Color(0xFFADFFDA),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
