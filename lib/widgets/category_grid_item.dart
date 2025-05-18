import 'package:find_your_meals/models/category.dart';
import 'package:find_your_meals/models/meal.dart';
import 'package:find_your_meals/screens/meals_screen.dart';
import 'package:flutter/material.dart';

class CategoryGridItem extends StatefulWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.availableMeals,
  });

  final Category category;
  final List<Meal> availableMeals;

  @override
  State<CategoryGridItem> createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends State<CategoryGridItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,

      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onPressCategoryHandler(BuildContext context) {
    final filteredMeals =
        widget.availableMeals
            .where((meal) => meal.categories.contains(widget.category.id))
            .toList();

    print('🟨  Filtered Meals =>>> $filteredMeals');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) =>
                MealsScreen(title: widget.category.title, meals: filteredMeals),
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
              widget.category.color.withOpacity(0.55),
              widget.category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Text(
          widget.category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
