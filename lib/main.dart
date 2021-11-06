import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/Category_meals.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/models/meal.dart';
import 'screens/categories.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  //We could have made this a model, but a Map is more quick.

  //We are going to make a favorites list.

  List<Meal> _favoriteMeals = [];

  List<Meal> _availableMeals = DUMMY_MEALS;

  bool filter(meal) {
    if (_filters['gluten'] && meal.isGlutenFree)
      return true;
    else if (_filters['lactose'] && meal.isLactoseFree)
      return true;
    else if (_filters['vegan'] && meal.isVegan)
      return true;
    else if (_filters['vegetarian'] && meal.isVegetarian)
      return true;
    else
      return false;
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(
      () {
        _filters =
            filterData; //overriding existing filters with the data that we have got.
        _availableMeals = DUMMY_MEALS.where((meal) {
          return filter(meal);
        }).toList();
      },
    );
    //Using where to filter DUMMY MEALS and we pass a function to where that returns true if we want to keep oit and false if we want to drop it. it receives a meal argument.
    // We have to also make sure that we have to adjust the meals that are being presented to the user using the filter.
  }

  void _toggleFavorite(String mealId) {
    //either add or remove
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0)
      setState(() {
        _favoriteMeals.removeAt(existingIndex); //wow smooth index management
      });
    else
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
  }

  bool _isFavorite(String id) {
    return _favoriteMeals.any((meal) =>
        meal.id ==
        id); //the any keyword runs the given anon function on every meal and checks the condition if any id matches the one that is selected.
  }

//this is not an optimal way, as whenever a favorite is toggled, the entire app is rebuilt using the build method.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals_app',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
            ),
      ),
      // home: CategoriesScreen(), The root screen as your app
      initialRoute:
          '/', // we can aslo define the default route using the initial route parameter
      routes: {
        '/': (ctx) => TabScreen(_favoriteMeals),
        // The '/' as in the normal web development, is used to refer to the default screen, we donot need the home: parameter, if we define the / route here.
        CategoryMeals.routeName: (ctx) => CategoryMeals(_availableMeals),
        // '/category-meals': (ctx) => CategoryMeals() The above code can also be defined like this, but the above is used for clean code management, as it refers to another variable that holds the id
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters,
            _setFilters), //setFilters is passed onto the named route as an argument for the constructor.
      },
      // We define a routes table to make navigation easier between individual pages onTap()
      // "routes:" takes a map of an id and function that executes the function when the id is called.
      // flutter also has its own inbuilt messaging system, that we can probably use to pass on objects without constructors.
      // onGenerateRoute: (settings) {
      // print(settings.arguments);
      // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
