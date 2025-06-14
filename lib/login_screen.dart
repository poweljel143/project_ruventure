import 'package:flutter/material.dart';
import 'select_city_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const Text(
                  "ruventure",
                  style: TextStyle(
                    fontFamily: "TT Norms Pro",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "Рады видеть Вас снова!",
              style: TextStyle(
                fontFamily: "TT Norms Pro",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Адрес эл.почты",
              style: TextStyle(
                fontFamily: "TT Norms Pro",
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.transparent),
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  initialValue: "helloworld@gmail.com",
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    hintText: "Введите адрес эл.почты",
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: Icon(Icons.check_circle, color: Colors.green),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Пароль",
              style: TextStyle(
                fontFamily: "TT Norms Pro",
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.transparent),
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 6),
                    hintText: "Введите пароль",
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
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
                  style: TextStyle(color: Colors.blueAccent),
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
                      MaterialPageRoute(
                          builder: (context) => SelectCityScreen()),
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
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
