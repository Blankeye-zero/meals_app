import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/models/meal.dart';
import 'favorites.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favorites;
  TabScreen(this.favorites);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': Text('Categories')},
      {'page': FavoritesScreen(widget.favorites), 'title': Text('Favorites')}
    ]; //smooth | isnt this called as a dictionary in python??
    super.initState();
  }
  // `widget.` property would not be available if the same variable is being initialized in another class using a constructor.
  //Therefore using initstate is the correct way

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _pages[_selectedPageIndex]['title'],
      ),
      drawer:
          MainDrawer(), //automatically renders a drawer (a navigation bar to the side) that we can add content to...(a navigation feature of flutter)
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex, //we can see what is selected.
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.shifting,
        // type:BottomNavigationBarType.shifting, //cool animation
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
