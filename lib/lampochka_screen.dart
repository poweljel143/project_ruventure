import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class LampochkaDetailScreen extends StatefulWidget {
  const LampochkaDetailScreen({super.key});

  @override
  State<LampochkaDetailScreen> createState() => _LampochkaDetailScreenState();
}

class _LampochkaDetailScreenState extends State<LampochkaDetailScreen> {
  final List<String> images = [
    'https://upload.wikimedia.org/wikipedia/commons/6/65/Tomsk_Gastrohall_Lampochka.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/9/9d/Tomsk_Lampochka_interior.jpg',
  ];
  int currentIndex = 0;

  Shader get iconGradient => const LinearGradient(
    colors: [Color(0xFF0212FE), Color(0xFFADFFDA)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 24.0, 24.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Лампочка', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: const [
          Icon(Icons.share, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() => currentIndex = index);
                    },
                    itemBuilder: (_, i) => Image.network(
                      images[i],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(images.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: currentIndex == index ? 12 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.white
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Лампочка гастрохолл',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map, size: 18),
                label: const Text("Показать на карте"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFADFFDA),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              RatingBarIndicator(
                rating: 4.5,
                itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 20.0,
              ),
              const SizedBox(width: 8),
              const Text("4.5", style: TextStyle(color: Colors.white)),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Показать отзывы",
                  style: TextStyle(color: Color(0xFFADFFDA)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _sectionCard(
            title: "О месте",
            icon: Icons.info_outline,
            content: const Text(
              '''
Современное городское пространство с историческим контекстом.

— Найти блюда по вкусу
— Прийти на концерт, шоу, лекцию
— Отдохнуть с друзьями
— Устроить свидание или поработать
              ''',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          _sectionCard(
            title: "Где находится",
            icon: Icons.place_outlined,
            content: const Text(
              "Пр. Кирова, 5 стр.1, ул. Белинского, 41\nКрасный район, 3 этаж",
              style: TextStyle(color: Colors.white),
            ),
          ),
          _sectionCard(
            title: "Часы работы",
            icon: Icons.schedule,
            content: const Text(
              "ВС–ЧТ: 08:00–23:00\nПТ–СБ: 08:00–00:00\nШаруйте круглосуточно",
              style: TextStyle(color: Colors.white),
            ),
          ),
          _sectionCard(
            title: "Контакты и соцсети",
            content: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _gradientIcon(Icons.language),
                  const SizedBox(width: 20),
                  _gradientIcon(Icons.alternate_email),
                  const SizedBox(width: 20),
                  _gradientIcon(Icons.send),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildReviewBlock(),
        ],
      ),
    );
  }

  Widget _gradientIcon(IconData icon) {
    return ShaderMask(
      shaderCallback: (Rect bounds) => iconGradient,
      child: Icon(icon, size: 30, color: Colors.white),
    );
  }

  Widget _sectionCard({required String title, IconData? icon, required Widget content}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            )
          else
            Text(title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }

  Widget _buildReviewBlock() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Отзывы", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _reviewItem(username: "Анна", text: "Уютное пространство, классная кухня!"),
          const Divider(color: Colors.grey),
          _reviewItem(username: "Максим", text: "Очень атмосферно, рекомендую!"),
        ],
      ),
    );
  }

  Widget _reviewItem({required String username, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(radius: 16, backgroundColor: Colors.grey),
            const SizedBox(width: 10),
            Text(username, style: const TextStyle(color: Colors.white)),
            const Spacer(),
            RatingBarIndicator(
              rating: 5,
              itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 16.0,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(text, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
