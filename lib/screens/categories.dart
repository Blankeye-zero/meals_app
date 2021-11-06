import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: DUMMY_CATEGORIES
          .map((catData) => CategoryItem(
                catData.id,
                catData.title,
                catData.color,
              ))
          .toList(),
      //passing a list to the map() function where we take each list item as an argument and render a widget iteratively for every list item
      //We use CategoryItem as the widget to be rendered, then all the widgets as a whole is then again composed into a list
      //a list object  that takes the color and title arguments.
      //how did dart know that catData is of type CategoryModel ?
      //oof Dummy categories in and itself is of type Category model. Now I feel like a fool lol.
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent:
            200, //defining(hardcoding) the width of each individual grid element
        childAspectRatio: 3 /
            5, //defining the height aspect ratio w.r to width of the element
        crossAxisSpacing: 20, //Horizontal spacing
        mainAxisSpacing: 20, //vertical spacing
      ),
    );
  }
}
