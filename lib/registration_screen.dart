import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';
import 'select_city_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isCheckboxChecked = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // Инициализация Supabase клиента
  final _supabase = Supabase.instance.client;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_isCheckboxChecked) {
      _showError('Примите условия и политику конфиденциальности');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Регистрация пользователя в Supabase Auth
      final authResponse = await _supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        data: {
          'name': _nameController.text.trim(),
        },
      );

      // 2. Сохранение дополнительных данных в таблицу profiles
      if (authResponse.user != null) {
        await _supabase.from('profiles').insert({
          'id': authResponse.user!.id,
          'email': _emailController.text.trim(),
          'full_name': _nameController.text.trim(),
          'created_at': DateTime.now().toIso8601String(),
        });
      }

      // 3. Переход на экран выбора города
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SelectCityScreen()),
      );
    } on AuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      _showError('Произошла ошибка при регистрации');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleAuthError(AuthException e) {
    String message = 'Ошибка регистрации';
    if (e.message.contains('already registered')) {
      message = 'Этот email уже зарегистрирован';
    } else if (e.message.contains('Invalid login credentials')) {
      message = 'Неверные учетные данные';
    }
    _showError(message);
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Оригинальные методы дизайна
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
      errorStyle: const TextStyle(color: Colors.red),
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
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
                _buildNameField(),
                _buildEmailField(),
                _buildPasswordField(isConfirm: false),
                _buildPasswordField(isConfirm: true),
                _buildCheckbox(),
                const SizedBox(height: 20),
                _buildGradientButton(),
                const SizedBox(height: 20),
                _buildLoginLink(),
                const SizedBox(height: 20),
              ],
            ),
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
            onPressed: () => Navigator.pop(context),
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

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Введите ваше имя",
          style: TextStyle(fontSize: 16, color: Color(0xFFADFFDA)),
        const SizedBox(height: 8),
        _gradientBorderWrapper(
          child: TextFormField(
            controller: _nameController,
            style: const TextStyle(color: Colors.white),
            decoration: _gradientInputDecoration(hintText: "Василиса"),
            validator: (value) => value?.isEmpty ?? true ? 'Введите имя' : null,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Адрес эл. почты",
          style: TextStyle(fontSize: 16, color: Color(0xFFADFFDA)),
        const SizedBox(height: 8),
        _gradientBorderWrapper(
          child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: _gradientInputDecoration(hintText: "helloworld@gmail.com"),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Введите email';
              if (!value!.contains('@')) return 'Некорректный email';
              return null;
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPasswordField({required bool isConfirm}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isConfirm ? "Повторите пароль" : "Пароль",
          style: const TextStyle(fontSize: 16, color: Color(0xFFADFFDA)),
        ),
        const SizedBox(height: 8),
        _gradientBorderWrapper(
          child: TextFormField(
            controller: isConfirm ? _confirmPasswordController : _passwordController,
            obscureText: isConfirm ? _obscureConfirmPassword : _obscurePassword,
            style: const TextStyle(color: Colors.grey),
            decoration: _gradientInputDecoration(
              hintText: '',
              suffixIcon: IconButton(
                icon: Icon(
                  isConfirm
                      ? _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility
                      : _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                  color: Colors.grey,
                  size: 18,
                ),
                onPressed: () => setState(() {
                  if (isConfirm) {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  } else {
                    _obscurePassword = !_obscurePassword;
                  }
                }),
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Введите пароль';
              if (value!.length < 6) return 'Минимум 6 символов';
              if (isConfirm && value != _passwordController.text) {
                return 'Пароли не совпадают';
              }
              return null;
            },
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
          onChanged: (value) => setState(() => _isCheckboxChecked = value ?? false),
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
        onPressed: _isCheckboxChecked && !_isLoading ? _registerUser : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size(301, 56),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "Создать аккаунт",
                style: TextStyle(
                  fontFamily: "TT Norms Pro",
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Уже есть аккаунт?", style: TextStyle(color: Colors.white)),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          ),
          child: const Text(
            "Войти",
            style: TextStyle(
              color: Color(0xFFADFFDA),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
