import 'package:find_your_meals/data/dummy_data.dart';
import 'package:find_your_meals/models/meal.dart';
import 'package:find_your_meals/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.5,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(category: category, availableMeals: availableMeals),
      ],
    );
  }
}
