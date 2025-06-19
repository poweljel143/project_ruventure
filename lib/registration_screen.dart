import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://pabqxlekiybzgzezansw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBhYnF4bGVraXliemd6ZXphbnN3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAzNTE3NjcsImV4cCI6MjA2NTkyNzc2N30.hNmgsaoYB64LWjdjrJvevJQB88izLKYAAxL6CogN9J4',
  );
  
  runApp(const MaterialApp(home: RegistrationScreen()));
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isCheckboxChecked = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final SupabaseClient _supabase = Supabase.instance.client;

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
      _showSnackBar('Примите условия и политику конфиденциальности', isError: true);
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar('Пароли не совпадают', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Регистрация пользователя
      final AuthResponse authResponse = await _supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        data: {
          'name': _nameController.text.trim(),
          'created_at': DateTime.now().toIso8601String(),
        },
      );

      if (authResponse.user == null) {
        throw Exception('Не удалось создать пользователя');
      }

      // 2. Сохранение профиля
      final profileResponse = await _supabase
          .from('profiles')
          .upsert({
            'id': authResponse.user!.id,
            'email': _emailController.text.trim(),
            'name': _nameController.text.trim(),
            'updated_at': DateTime.now().toIso8601String(),
          });

      if (profileResponse.error != null) {
        throw Exception(profileResponse.error!.message);
      }

      _showSnackBar('Регистрация успешна! Проверьте вашу почту.', isError: false);
      if (mounted) Navigator.pop(context);
      
    } on AuthException catch (e) {
      _showSnackBar('Ошибка регистрации: ${e.message}', isError: true);
    } catch (e) {
      _showSnackBar('Ошибка: ${e.toString()}', isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFADFFDA)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Center(
          child: GradientText(
            "ruventure",
            gradient: LinearGradient(colors: [Color(0xFF0212FE), Color(0xFFADFFDA)]),
            style: TextStyle(
              fontFamily: "TT Norms Pro",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                _buildNameField(),
                _buildEmailField(),
                _buildPasswordField(),
                _buildConfirmPasswordField(),
                _buildTermsCheckbox(),
                const SizedBox(height: 20),
                _buildRegisterButton(),
                if (_isLoading) const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: _inputDecoration("Введите ваше имя", "Василиса"),
      style: const TextStyle(color: Colors.white),
      validator: (value) => value?.isEmpty ?? true ? 'Введите имя' : null,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: _inputDecoration("Адрес эл. почты", "example@mail.com"),
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value?.isEmpty ?? true) return 'Введите email';
        if (!value!.contains('@')) return 'Некорректный email';
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: _inputDecoration("Пароль", "").copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value?.isEmpty ?? true) return 'Введите пароль';
        if (value!.length < 6) return 'Минимум 6 символов';
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPassword,
      decoration: _inputDecoration("Повторите пароль", "").copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
          onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value != _passwordController.text) return 'Пароли не совпадают';
        return null;
      },
    );
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(color: Colors.white),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isCheckboxChecked,
          onChanged: (bool? value) => setState(() => _isCheckboxChecked = value ?? false),
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xFFADFFDA);
            }
            return Colors.grey;
          }),
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

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _registerUser,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: _isCheckboxChecked && !_isLoading
              ? const LinearGradient(
                  colors: [Color(0xFF0212FE), Color(0xFFADFFDA)],
                )
              : const LinearGradient(
                  colors: [Colors.grey, Colors.grey],
                ),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Center(
              child: Text(
                "Создать аккаунт",
                style: TextStyle(
                  fontFamily: "TT Norms Pro",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    required this.style,
    super.key,
  });

  final String text;
  final TextStyle style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
