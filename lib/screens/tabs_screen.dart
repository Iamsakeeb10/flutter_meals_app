import 'package:find_your_meals/providers/favorites_provider.dart';
import 'package:find_your_meals/providers/filters_provider.dart';
import 'package:find_your_meals/screens/categories_screen.dart';
import 'package:find_your_meals/screens/filters_screen.dart';
import 'package:find_your_meals/screens/meals_screen.dart';
import 'package:find_your_meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void showSnackbar(String content) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(content)));
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void drawerNavigationHandler(String identifer) async {
    Navigator.of(context).pop();

    if (identifer == 'filters') {
      Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(builder: (ctx) => FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeScreen = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);

      activeScreen = MealsScreen(meals: favoriteMeals);
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activeScreen,

      drawer: MainDrawer(onTapDrawerItem: drawerNavigationHandler),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
        onTap: (value) {
          _selectPage(value);
        },
      ),
    );
  }
}
