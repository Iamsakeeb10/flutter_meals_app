import 'package:find_your_meals/models/meal.dart';
import 'package:flutter/material.dart';

class MealsDetailsScreen extends StatefulWidget {
  const MealsDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFavorite,
    required this.favoriteMeals,
  });

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> favoriteMeals;

  @override
  State<MealsDetailsScreen> createState() => _MealsDetailsScreenState();
}

class _MealsDetailsScreenState extends State<MealsDetailsScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.favoriteMeals.any(
      (element) => element.id == widget.meal.id,
    );
  }

  void _toggleFavorite() {
    widget.onToggleFavorite(widget.meal);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: isFavorite ? Icon(Icons.star) : Icon(Icons.star_outline),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Image.network(
                widget.meal.imageUrl,
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
              SizedBox(height: 14),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 14),
              for (final ingredient in widget.meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              SizedBox(height: 24),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 14),
              for (final step in widget.meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
