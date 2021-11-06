import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favorites;
  FavoritesScreen(this.favorites);

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty)
      return Container(
        child: Center(child: Text('You dont have favorites yet')),
      );
    else
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favorites[index].id,
            title: favorites[index].title,
            imageUrl: favorites[index].imageUrl,
            duration: favorites[index].duration,
            complexity: favorites[index].complexity,
            affordability: favorites[index].affordability,
          );

          //return Text(categoryMeals[index]
          //    .title); //testing whether the ListView actually returns the intended elements.
        },
        itemCount: favorites.length,
      );
  }
}
