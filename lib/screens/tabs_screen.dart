import 'package:find_your_meals/data/dummy_data.dart';
import 'package:find_your_meals/models/meal.dart';
import 'package:find_your_meals/screens/categories_screen.dart';
import 'package:find_your_meals/screens/filters_screen.dart';
import 'package:find_your_meals/screens/meals_screen.dart';
import 'package:find_your_meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

const kFilterInitializer = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kFilterInitializer;

  void showSnackbar(String content) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(content)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      showSnackbar('Removed from favorites.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      showSnackbar('Added to favorites!');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void drawerNavigationHandler(String identifer) async {
    Navigator.of(context).pop();

    if (identifer == 'filters') {
      final result = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(builder: (ctx) => FiltersScreen()),
      );

      setState(() {
        _selectedFilters = result ?? kFilterInitializer;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals =
        dummyMeals.where((meal) {
          if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
            return false;
          }
          if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
            return false;
          }

          return true;
        }).toList();

    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      favoriteMeals: _favoriteMeals,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
        favoriteMeals: _favoriteMeals,
      );
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
