import 'package:find_your_meals/models/meal.dart';
import 'package:find_your_meals/screens/meals_details_screen.dart';
import 'package:find_your_meals/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => MealsDetailsScreen(meal: meal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return MealItem(
            meal: meal,
            onSelectMeal: (meal) {
              selectMeal(context, meal);
            },
          );
        },
      ),
    );

    if (meals.isEmpty) {
      mainContent = Center(
        child: Text(
          'Oops! There is no meals yet...',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      appBar: title != null ? AppBar(title: Text(title!)) : null,
      body: mainContent,
    );
  }
}
