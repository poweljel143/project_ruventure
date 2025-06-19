import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
        // Серая верхняя панель с скруглёнными нижними углами
        Container(
        decoration: BoxDecoration(
        color: Colors.grey[900],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        padding: const EdgeInsets.only(
          top: 48,
          left: 16,
          right: 16,
          bottom: 12,
        ),
        child: _isSearching
            ? Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromRGBO(173, 255, 218, 1.0)),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                });
              },
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Поиск по избранному',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFADFFDA),
                    Color(0xFF0072FF),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Логика поиска
                  final query = _searchController.text;
                  print('Поиск: $query');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Найти',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        )
            : Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromRGBO(173, 255, 218, 1.0)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Избранное',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search,
                  color: Color.fromRGBO(173, 255, 218, 1.0)),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            ),
          ],
        ),
      ),

      // Вкладки в виде островка
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
        child: Container(
          height: 34,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(44, 44, 44, 1.0),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(2, 18, 255, 1.0).withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: TabBar(
            tabs: const [
              Tab(text: 'Все места'),
              Tab(text: 'Коллекции'),
            ],
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[600],
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[400],
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
          ),
        ),
      ),

      // Контентная часть
      Expanded(
        child: TabBarView(
          children: [
        // Содержимое вкладки "Все места"
        Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Здесь будут сохранены ваши любимые места',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(text: 'Чтобы добавить место в избранное нажмите на иконку '),
                  WidgetSpan(
                    child: Icon(
                      Icons.star_border,
                      color: Color.fromRGBO(173, 255, 218, 1.0),
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(text: 'Чтобы его удалить нажмите еще раз на иконку '),
                  WidgetSpan(
                    child: Icon(
                      Icons.star_border,
                      color: Color.fromRGBO(173, 255, 218, 1.0),
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Содержимое вкладки "Коллекции"
      const Center(
        child: Text('Ваши коллекции', style: TextStyle(color: Colors.white))),
        ],
      ),
    ),
    ],
    ),
    ),
    );
  }
}