import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      drawer: const _AppDrawer(),
      body: const CustomScrollView(
        slivers: [
          _HeaderAppBar(),
          _SearchAndFilterSection(),
          _PlacesGrid(),
        ],
      ),
    );
  }
}


class _HeaderAppBar extends StatefulWidget {
  const _HeaderAppBar();

  @override
  State<_HeaderAppBar> createState() => _HeaderAppBarState();
}

class _HeaderAppBarState extends State<_HeaderAppBar> {
  final List<String> images = [
    'assets/image/tomsk_1.png',
    'assets/image/tomsk_2.png',
    'assets/image/tomsk_3.png',
  ];

  int selected = 0;

  void rotateTo(int index) {
    setState(() {
      final delta = (index - selected + 3) % 3;
      if (delta == 1) {
        images.insert(0, images.removeLast());
      } else if (delta == 2) {
        images.add(images.removeAt(0));
      }
      selected = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF000000),
      expandedHeight: 400,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white70, size: 24,),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),

      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(top: 10), // Отступ сверху
          child: Stack(
            children: [
              _buildImageStack(),
              const Positioned(
                left: 225,
                top: 90,
                child: Text(
                  'Куда\nсходить\nв Томске?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageStack() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
      child: Stack(
        children: [
          buildImage(images[0], 150, 150, const Offset(25, 175), true, 1),
          buildImage(images[1], 150, 150, const Offset(190, 175), true, 2),
          buildImage(images[2], 150, 150, const Offset(25, 15), false, 0),
        ],
      ),
    );
  }

  Widget buildImage(String asset, double width, double height, Offset offset, bool isDimmed, int index) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onTap: isDimmed ? () => rotateTo(index) : null,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDimmed ? Color(0xFFADFFDA) : Color(0xFFADFFDA),
              width: 2,
            ),
            image: DecorationImage(
              image: AssetImage(asset),
              fit: BoxFit.cover,
              colorFilter: isDimmed
                  ? ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchAndFilterSection extends StatelessWidget {
  const _SearchAndFilterSection();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  hintText: 'Поиск',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  prefixIcon:
                  Icon(Icons.search, color: Colors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: const Color(0xFF000000),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_list, color: Colors.white70),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border, color: Colors.white70),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlacesGrid extends StatefulWidget {
  const _PlacesGrid();

  @override
  State<_PlacesGrid> createState() => _PlacesGridState();
}

class _PlacesGridState extends State<_PlacesGrid> {
  final List<Map<String, dynamic>> places = [
    {'name': 'Лампочка', 'type': 'гастрохолл', 'image': 'assets/image/place_1.jpg', 'isFavorite': false},
    {'name': 'Лагерный сад', 'type': 'парк', 'image': 'assets/image/place_2.png', 'isFavorite': false},
    {'name': 'Ново-Соборная пл.', 'type': 'центральная площадь', 'image': 'assets/image/place_3.png', 'isFavorite': false},
    {'name': 'Городской сад', 'type': 'парк культуры и отдыха', 'image': 'assets/image/place_4.png', 'isFavorite': false},
    {'name': 'Театр "2+ку"', 'type': 'театр живых кукол', 'image': 'assets/image/place_5.png', 'isFavorite': false},
    {'name': 'Бот. сад ТГУ', 'type': 'заповедный парк', 'image': 'assets/image/place_6.png', 'isFavorite': false},
  ];

  void toggleFavorite(int index) {
    setState(() {
      places[index]['isFavorite'] = !places[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final place = places[index];
            return _PlaceCard(
              imagePath: place['image'],
              name: place['name'],
              type: place['type'],
              isFavorite: place['isFavorite'],
              onFavoriteToggle: () => toggleFavorite(index),
            );
          },
          childCount: places.length,
        ),
      ),
    );
  }
}


class _PlaceCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String type;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const _PlaceCard({
    required this.imagePath,
    required this.name,
    required this.type,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: GestureDetector(
              onTap: onFavoriteToggle,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: isFavorite
                    ? ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [Color(0xFFADFFDA), Color(0xFF0212FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: const Icon(Icons.favorite, size: 25, color: Colors.white),
                )
                    : const Icon(Icons.favorite_border, color: Colors.white, size: 25),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  type,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF131313),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 50),

          // Аватар, имя и город
          Column(
            children: const [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/image/avatar.png'), // Заменить при необходимости
              ),
              SizedBox(height: 12),
              Text(
                'Имя пользователя',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                'г. Томск',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Категории
          _favoriteItemWithGradientIcon('Избранное'),
          _simpleTextItem('Места'),
          _simpleTextItem('Маршруты'),
          _simpleTextItem('Вкусно поесть'),
          _simpleTextItem('По барам'),
          _simpleTextItem('Сувениры'),
          _simpleTextItem('Музеи'),
          _simpleTextItem('Достопримечательности'),
          _simpleTextItem('Прогулки на корабле'),
          _simpleTextItem('Интересное детям'),

          const SizedBox(height: 40),

          // Нижние пункты
          _simpleTextItem('Настройки'),
          _simpleTextItem('О приложении'),
          _simpleTextItem('Обратная связь'),
        ],
      ),
    );
  }

  Widget _favoriteItemWithGradientIcon(String title) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00F5A0), Color(0xFF0212FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              'Избранное',
              style: TextStyle(
                color: Colors.white, // перекрывается ShaderMask
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00F5A0), Color(0xFF0212FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Icon(
              Icons.favorite_border,
              size: 22,
              color: Colors.white,
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _simpleTextItem(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () {},
    );
  }
}
