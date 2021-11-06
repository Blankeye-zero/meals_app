import 'package:flutter/material.dart';
import '../screens/Category_meals.dart';
//this is the grid item that is iteratively rendered for n number of grid elements.

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  CategoryItem(this.id, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    void selectCategory() {
      //The BuildContext class reference here allows us to define a variable to store metadata. Here the defined variable is ctx.
      Navigator.of(context).pushNamed(CategoryMeals.routeName, arguments: {
        'id': id,
        'title': title,
      });
      //The pushNamed() does not take Material Page route as push does, but instead takes a string identifier that we hasve defined in the routes table in the main dart file.
      //pushNamed aslo takes arguments, therefore enabling us to pass an id and title as a map using strings.
      //another way to  use push()
      //Navigator.of(context).push(
      //MaterialPageRoute(
      //builder: (_) {
      //return CategoryMeals(id, title);
      //},
      // The underscore represents an empty set of parameters or a null set, we use this here because we are not going to call the function directly.
      //),
      //); a class built into flutter to navigate to different pages - Navigator . Pages are managed as a stack where the top most page is visible, while when we navigate to another page , we use the stack index to make the requested page to be top most.
    }

    return InkWell(
      onTap: selectCategory,
//      splashColor: Theme.of(context).primaryColor,
//    borderRadius: BorderRadius.circular(15),
      child: Container(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
