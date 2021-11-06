import 'package:flutter/foundation.dart';

enum Complexity {
  Simple,
  Challenging,
  Hard
} // we create a new enum by this code. It is essentially a type that helps us to create choices among a couple of alternatives.
//Now we can use this enum to asses the difficulty of the recipe.

enum Affordability { Affordable, Pricey, Luxurious }

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String
      imageUrl; // we donot have to hard code the image into the app bundle
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal(
      {@required this.id,
      @required this.categories,
      @required this.title,
      @required this.imageUrl,
      @required this.ingredients,
      @required this.steps,
      @required this.duration,
      @required this.affordability,
      @required this.complexity,
      @required this.isGlutenFree,
      @required this.isLactoseFree,
      @required this.isVegan,
      @required this.isVegetarian});
}
