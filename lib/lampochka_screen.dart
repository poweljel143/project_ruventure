import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(home: LampochkaDetailScreen()));
}

class LampochkaDetailScreen extends StatefulWidget {
  const LampochkaDetailScreen({super.key});

  @override
  State<LampochkaDetailScreen> createState() => _LampochkaDetailScreenState();
}

class _LampochkaDetailScreenState extends State<LampochkaDetailScreen> {
  final List<String> _galleryImages = [
    'https://upload.wikimedia.org/wikipedia/commons/6/65/Tomsk_Gastrohall_Lampochka.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/9/9d/Tomsk_Lampochka_interior.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/6/65/Tomsk_Gastrohall_Lampochka.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/9/9d/Tomsk_Lampochka_interior.jpg',
  ];
  int _currentImageIndex = 0;
  bool _isFavorite = false;

  // Координаты и адрес
  static const LatLng _location = LatLng(56.4846, 84.9476);
  static const String _address = 'Пр. Кирова, 5 стр.1, ул. Белинского, 41';

  // Градиент для иконок
  final Shader _gradientShader = const LinearGradient(
    colors: [Color(0xFF0212FE), Color(0xFFADFFDA)],
  ).createShader(const Rect.fromLTWH(0, 0, 24, 24));

  // Открытие в Google Maps
  Future<void> _launchGoogleMaps() async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(_address)}',
    );
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch maps');
    }
  }

  // Открытие встроенной карты
  void _openMapScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Лампочка на карте')),
          body: GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _location,
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('lampochka'),
                position: _location,
                infoWindow: const InfoWindow(
                  title: 'Лампочка гастрохолл',
                  snippet: _address,
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure,
                ),
              ),
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () => setState(() => _isFavorite = !_isFavorite),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Галерея изображений
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    itemCount: _galleryImages.length,
                    onPageChanged: (index) => 
                      setState(() => _currentImageIndex = index),
                    itemBuilder: (_, index) => Image.network(
                      _galleryImages[index],
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, progress) => 
                        progress == null ? child : const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ),
                  ),
                  _buildImageIndicator(),
                ],
              ),
            ),
          ),

          // Основной контент
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Заголовок и рейтинг
                  _buildHeaderSection(),
                  const SizedBox(height: 24),
                  
                  // Карточки с информацией
                  _buildInfoCard(
                    icon: Icons.info_outline,
                    title: 'О месте',
                    child: const Text(
                      'Современное городское пространство с историческим контекстом.\n\n'
                      '• Найти блюда по вкусу\n'
                      '• Прийти на концерт или лекцию\n'
                      '• Отдохнуть с друзьями\n'
                      '• Устроить свидание или поработать',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  
                  _buildInfoCard(
                    icon: Icons.location_on_outlined,
                    title: 'Где находится',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          _address,
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: const Icon(Icons.map, size: 18),
                                label: const Text('Google Maps'),
                                onPressed: _launchGoogleMaps,
                                style: _outlinedButtonStyle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.explore, size: 18),
                                label: const Text('На карте'),
                                onPressed: _openMapScreen,
                                style: _elevatedButtonStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  _buildInfoCard(
                    icon: Icons.access_time,
                    title: 'Часы работы',
                    child: const Text(
                      'ВС–ЧТ: 08:00–23:00\n'
                      'ПТ–СБ: 08:00–00:00\n'
                      'Шаруйте круглосуточно',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  
                  // Отзывы
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Отзывы',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildReviewItem('Анна', 5, 'Уютное пространство, классная кухня!'),
                  _buildReviewItem('Максим', 4, 'Очень атмосферно, рекомендую!'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Стили кнопок
  final ButtonStyle _elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFADFFDA),
    foregroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  final ButtonStyle _outlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFFADFFDA),
    side: const BorderSide(color: Color(0xFFADFFDA)),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  // Индикатор текущего изображения
  Widget _buildImageIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _galleryImages.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _currentImageIndex == index ? 24 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: _currentImageIndex == index 
                  ? const Color(0xFFADFFDA) 
                  : Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  // Шапка с названием и рейтингом
  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Лампочка гастрохолл',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            RatingBarIndicator(
              rating: 4.5,
              itemCount: 5,
              itemSize: 20,
              itemBuilder: (_, __) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              '4.5 (128 отзывов)',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }

  // Карточка с информацией
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
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
          Row(
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) => _gradientShader,
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  // Элемент отзыва
  Widget _buildReviewItem(String name, int rating, String text) {
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
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RatingBarIndicator(
                    rating: rating.toDouble(),
                    itemCount: 5,
                    itemSize: 16,
                    itemBuilder: (_, __) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
