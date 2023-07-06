import 'package:course_08_meals/screens/categories_screen.dart';
import 'package:course_08_meals/screens/meals_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  var pageTitle = 'Kategorie';

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      pageTitle = 'Ulubione';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoriesScreen();

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(meals: []);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Kategorie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Ulubione',
          ),
        ],
      ),
    );
  }
}
