import 'package:flutter/material.dart';
import 'select_city_screen.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isCheckboxChecked = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  InputDecoration _gradientInputDecoration({required String hintText, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.black,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide.none,
      ),
      suffixIcon: suffixIcon,
    );
  }

  Widget _gradientBorderWrapper({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0212FE), Color(0xFFADFFDA)],
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.all(1.5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(32),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50), // отступ от верхнего края
              _buildHeader(context),
              const SizedBox(height: 24),
              const Text(
                "Создание аккаунта",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "TT Norms Pro",
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              _buildLabeledField("Введите ваше имя", "Василиса"),
              _buildLabeledField("Адрес эл. почты", "helloworld@gmail.com"),
              _buildPasswordField("Пароль", isConfirm: false),
              _buildPasswordField("Повторите пароль", isConfirm: true),
              _buildCheckbox(),
              const SizedBox(height: 20),
              _buildGradientButton(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Уже есть аккаунт?",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Войти",
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
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFADFFDA)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF0212FE), Color(0xFFADFFDA)],
          ).createShader(bounds),
          child: const Text(
            "ruventure",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: "TT Norms Pro",
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildLabeledField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Color(0xFFADFFDA))),
        const SizedBox(height: 8),
        _gradientBorderWrapper(
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: _gradientInputDecoration(hintText: hint),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPasswordField(String label, {required bool isConfirm}) {
    bool obscure = isConfirm ? _obscureConfirmPassword : _obscurePassword;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Color(0xFFADFFDA))),
        const SizedBox(height: 8),
        _gradientBorderWrapper(
          child: TextField(
            obscureText: obscure,
            style: const TextStyle(color: Colors.grey),
            decoration: _gradientInputDecoration(
              hintText: '',
              suffixIcon: IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                  size: 18,
                ),
                onPressed: () {
                  setState(() {
                    if (isConfirm) {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    } else {
                      _obscurePassword = !_obscurePassword;
                    }
                  });

                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isCheckboxChecked,
          onChanged: (value) {
            setState(() {
              _isCheckboxChecked = value ?? false;
            });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          activeColor: const Color(0xFFADFFDA),
        ),
        const Expanded(
          child: Text(
            "Я принимаю условия и политику конфиденциальности",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildGradientButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: _isCheckboxChecked
            ? const LinearGradient(colors: [Color(0xFF0212FE), Color(0xFFADFFDA)])
            : const LinearGradient(colors: [Colors.grey, Colors.grey]),
        borderRadius: BorderRadius.circular(32),
      ),
      child: ElevatedButton(
        onPressed: _isCheckboxChecked ? () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SelectCityScreen()),
          );
        } : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size(301, 56),
        ),
        child: const Text(
          "Создать аккаунт",
          style: TextStyle(fontFamily: "TT Norms Pro", fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
