import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lesson_1/features/news/ui/pages/everything_page.dart';
import 'package:lesson_1/features/news/ui/pages/favourites_page.dart';
import 'package:lesson_1/features/news/ui/pages/menu_page.dart';
import 'package:lesson_1/features/news/ui/pages/news_page.dart';
import 'package:lesson_1/features/news/ui/widgets/app_bottom_navigation.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    NewsPage(),
    FavouritesPage(),
    EverythingPage(),
    MenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
