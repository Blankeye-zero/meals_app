import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMeals extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMeals(this.availableMeals);

  @override
  _CategoryMealsState createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedinitData =
      false; // this bool is used as a mark to show the app that we are done initializing once we get context. If this var isnt used
  //It makes it hard to change state as, didChangeDependencies lifecycle hook reruns the state again after initializing and thus the state dosent change at all even when we click the remove button.

  void initState() {
    //...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedinitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>; //?
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(
            categoryId); //it returns true if the element categoryId is present.
      }).toList(); //DUMMY_MEALS can be filtered with the "where" method which is further converted into a list using ToList()
      _loadedinitData = true;
    }
    super.didChangeDependencies();
  } //for initializing final in a stateful widget

  //lifecycle hook
  //This will be triggered essentially whenever the referances of the state change - which also means that the
  //widget that belongs to the state has been fully initialized and we can tap into context
  // We pass on the code that uses context to didChangeDependencies from initState() since, initState cannot process context as it runs before build().
  //This lifecycle hook runs before build but executes the context code once context initializes.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
          );

          //return Text(categoryMeals[index]
          //    .title); //testing whether the ListView actually returns the intended elements.
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
