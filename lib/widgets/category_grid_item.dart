import 'package:find_your_meals/models/category.dart';
import 'package:find_your_meals/models/meal.dart';
import 'package:find_your_meals/screens/meals_screen.dart';
import 'package:flutter/material.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onToggleFavorite,
    required this.favoriteMeals,
    required this.availableMeals,
  });

  final Category category;
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> favoriteMeals;
  final List<Meal> availableMeals;

  void onPressCategoryHandler(BuildContext context) {
    final filteredMeals =
        availableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
              onToggleFavorite: onToggleFavorite,
              favoriteMeals: favoriteMeals,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressCategoryHandler(context);
      },
      borderRadius: BorderRadius.circular(8.0),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
