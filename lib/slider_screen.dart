import 'package:flutter/material.dart';
import 'auth_screen.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  int currentIndex = 0;

  final List<Map<String, String>> sliderData = [
    {"text": "Откройте для себя \nновые места!", "image": "assets/image/image1.jpg"},
    {"text": "Планируйте маршруты\n с легкостью!", "image": "assets/image/image2.jpg"},
    {"text": "Делитесь своими \nвпечатлениями!", "image": "assets/image/image3.jpg"},
    {"text": "Сохраняйте любимые места!", "image": "assets/image/image4.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: sliderData.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      width: 280,
                      height: 255,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          width: 1,
                          color: Colors.transparent,
                        ),
                        gradient: null,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            width: 1,
                            color: Colors.transparent,
                          ),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(2, 18, 254, 1),
                              Color.fromRGBO(173, 255, 218, 1),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: Image.asset(
                            sliderData[index]["image"]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 140), // Подняли текст ниже
                    Text(
                      sliderData[index]["text"]!,
                      style: const TextStyle(
                        fontFamily: "TT Norms Pro",
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                  ],
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    sliderData.length,
                        (index) => buildDot(index),
                  ),
                ),
                const SizedBox(height: 100),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Container(
                      width: 138,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(2, 18, 254, 1), // Синий
                            Color.fromRGBO(173, 255, 218, 1), // Бирюзовый
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2), // Толщина ободка
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black, // Основной цвет кнопки
                            borderRadius: BorderRadius.circular(14), // На 2px меньше, чем внешний радиус
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AuthScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // Прозрачный фон
                              shadowColor: Colors.transparent, // Убираем тень
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Пропустить',
                                style: TextStyle(
                                  fontFamily: "TT Norms Pro Medium",
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
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

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 10,
      width: currentIndex == index ? 14 : 14,
      decoration: BoxDecoration(
        color: currentIndex == index ? Color.fromRGBO(2, 18, 255, 1.0) : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
