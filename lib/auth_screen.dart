import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(173, 255, 218, 1)),
              ),
            ),
            const Spacer(flex: 5),
            Center(
              child: Container(
                width: 218,
                height: 118,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image/logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    Color.fromRGBO(2, 18, 254, 1),   // Синий
                    Color.fromRGBO(173, 255, 218, 1), // Бирюзовый
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds);
              },
              child: const Text(
                "Любимые места \nв одном приложении",
                style: TextStyle(
                  fontFamily: "TT Norms Pro",
                  fontSize: 32,
                  color: Colors.white, // Важно: должен быть белый для работы градиента
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 150),
            const Text(
              "Войдите или зарегистрируйтесь, чтобы \nиспользовать приложение",
              style: TextStyle(fontFamily: "TT Norms Pro", fontSize: 18, color: Color.fromRGBO(
                  255, 255, 255, 1.0)),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // Новая градиентная кнопка со свечением
            Container(
              width: 301,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(2, 18, 254, 0.5), // Слабое синее свечение
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(2, 18, 254, 1),   // Синий
                        Color.fromRGBO(173, 255, 218, 1.0),   // Голубой
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    width: 301,
                    height: 56,
                    alignment: Alignment.center,
                    child: const Text(
                      "Войти",
                      style: TextStyle(
                        fontFamily: "TT Norms Pro",
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [
                          Shadow( // Дополнительное свечение текста
                            blurRadius: 10,
                            color: Color.fromRGBO(173, 255, 218, 0.7),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(301, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: const Text(
                "Создать аккаунт",
                style: TextStyle(fontFamily: "TT Norms Pro",fontSize: 20, color: Color.fromRGBO(173, 255, 218, 1)),
              ),
            ),
            const Spacer(flex: 10,),
          ],
        ),
      ),
    );
  }
}