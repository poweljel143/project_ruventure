import 'package:flutter/material.dart';
import 'select_city_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [
                        Color.fromRGBO(2, 18, 254, 1),
                        Color.fromRGBO(173, 255, 218, 1),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds);
                  },
                  child: const Text(
                    "ruventure",
                    style: TextStyle(
                      fontFamily: "TT Norms Pro",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "Рады видеть Вас снова!",
              style: TextStyle(
                fontFamily: "TT Norms Pro",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Адрес эл.почты",
              style: TextStyle(
                fontFamily: "TT Norms Pro",
                fontSize: 16,
                color: Color(0xFFADFFDA),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 48, // Фиксированная высота
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(2, 18, 254, 1),
                    Color.fromRGBO(173, 255, 218, 1),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Align( // Выравнивание по верхнему краю
                  alignment: Alignment.topCenter,
                  child: TextFormField(
                    initialValue: "helloworld@gmail.com",
                    style: const TextStyle(
                      color: Colors.white,
                      height: 1.0, // Убираем лишнюю высоту
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        left: 12,
                        top: 15, // Отступ сверху
                        bottom: 8,
                      ),
                      hintText: "Введите адрес эл.почты",
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: 3), // Выравниваем иконку
                        child: Icon(Icons.check_circle, color: Colors.grey),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Пароль",
              style: TextStyle(
                fontFamily: "TT Norms Pro",
                fontSize: 16,
                color: Color(0xFFADFFDA),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 48, // Фиксированная высота
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(2, 18, 254, 1),
                    Color.fromRGBO(173, 255, 218, 1),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Align( // Выравнивание по верхнему краю
                  alignment: Alignment.topCenter,
                  child: TextFormField(
                    obscureText: _obscurePassword,
                    style: const TextStyle(
                      color: Colors.white,
                      height: 1.0, // Убираем лишнюю высоту
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        left: 12,
                        top: 15, // Отступ сверху
                        bottom: 8,
                      ),
                      hintText: "Введите пароль",
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 3), // Выравниваем иконку
                        child: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Забыли пароль?",
                  style: TextStyle(
                    color: Color.fromRGBO(173, 255, 218, 1),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(2, 18, 254, 1),
                    Color.fromRGBO(173, 255, 218, 1),
                  ]),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectCityScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    minimumSize: const Size(301, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: const Text(
                    "Войти",
                    style: TextStyle(
                      fontFamily: "TT Norms Pro",
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Нет аккаунта?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationScreen()),
                    );
                  },
                  child: const Text(
                    "Создать аккаунт",
                    style: TextStyle(
                      color: Color.fromRGBO(173, 255, 218, 1),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}