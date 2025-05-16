import 'package:find_your_meals/models/meal.dart';
import 'package:find_your_meals/widgets/meal_item_content.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final Function(Meal meal) onSelectMeal;

  get getComplexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  get getAffordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 6.0,
        child: InkWell(
          onTap: () {
            onSelectMeal(meal);
          },
          splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
          child: Stack(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12.0),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemContent(
                            icon: Icons.alarm,
                            label: '${meal.duration} min',
                          ),
                          SizedBox(width: 10.0),
                          MealItemContent(
                            icon: Icons.shopping_bag,
                            label: getComplexityText,
                          ),

                          SizedBox(width: 10.0),

                          MealItemContent(
                            icon: Icons.monetization_on,
                            label: getAffordabilityText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
