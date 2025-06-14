import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isCheckboxChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(173, 255, 218, 1)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color.fromRGBO(2, 18, 254, 1), Color.fromRGBO(173, 255, 218, 1)],
            ).createShader(bounds),
            child: const Text(
              "ruventure",
              style: TextStyle(
                fontFamily: "TT Norms Pro",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        titleSpacing: 0,
        toolbarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Создание аккаунта",
                style: TextStyle(
                  fontFamily: "TT Norms Pro",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _buildInputField("Введите ваше имя", "Василиса"),
              _buildInputField("Адрес эл. почты", "helloworld@gmail.com"),
              _buildPasswordField("Пароль"),
              _buildPasswordField("Повторите пароль"),
              _buildCheckbox(),
              const SizedBox(height: 20),
              _buildGradientButton(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPasswordField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.visibility_off, color: Colors.white),
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: const BorderSide(color: Colors.white),
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
          onChanged: (bool? value) {
            setState(() {
              _isCheckboxChecked = value ?? false;
            });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        const Expanded(
          child: Text(
            "Я принимаю условия и политику конфиденциальности",
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildGradientButton() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isCheckboxChecked ? [Color.fromRGBO(2, 18, 254, 1), Color.fromRGBO(173, 255, 218, 1)] : [Colors.grey, Colors.grey],
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        child: ElevatedButton(
          onPressed: _isCheckboxChecked ? () {} : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            minimumSize: const Size(301, 56),
          ),
          child: const Text(
            "Создать аккаунт",
            style: TextStyle(fontFamily: "TT Norms Pro", color: Colors.white),
          ),
        ),
      ),
    );
  }
}
