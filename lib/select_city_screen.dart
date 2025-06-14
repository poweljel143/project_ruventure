import 'package:flutter/material.dart';
import 'home_screen.dart';

class SelectCityScreen extends StatefulWidget {
  const SelectCityScreen({Key? key}) : super(key: key);

  @override
  State<SelectCityScreen> createState() => _SelectCityScreenState();
}

class _SelectCityScreenState extends State<SelectCityScreen> {
  String selectedCity = "Москва";
  final List<String> cities = [
    'Москва',
    'Санкт-Петербург',
    'Казань',
    'Новосибирск'
  ];

  void _navigateToHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Icon(
                Icons.apartment,
                color: Color.fromRGBO(2, 18, 254, 1),
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                "Выберите город, \nв котором вы хотите найти \nинтересные места",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "В дальнейшем его можно будет изменить",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(2, 18, 254, 1),
                      Color.fromRGBO(173, 255, 218, 1)
                    ],
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCity,
                    dropdownColor: Colors.black,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                    items: cities.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(city),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedCity = newValue;
                        });
                      }
                    },
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _navigateToHomeScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Далее",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}