import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;

  FilterScreen(this.currentFilters, this.saveFilters);

  final Map<String, bool> currentFilters;

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenfree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactosefree = false;

  @override
  initState() {
    _glutenfree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactosefree = widget.currentFilters['lactose'];
    setState(() {});
    super.initState();
  }

  Widget _switches(bool currentvalue, String title, String description,
      Function updatevalue) {
    return SwitchListTile(
      title: Text(title),
      value: currentvalue,
      subtitle: Text(
        description,
      ),
      onChanged: updatevalue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenfree,
                  'lactose': _lactosefree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              }, //reaching out to our widget using the special widget property inside of state objects on state classes.
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text('Adjust your meal selection',
                  style: Theme.of(context).textTheme.headline6),
            ),
            Expanded(
                child: ListView(
              children: <Widget>[
                _switches(
                  _glutenfree,
                  'gluten-free',
                  'only include gluten free meals',
                  (newvalue) {
                    setState(
                      () {
                        _glutenfree = newvalue;
                      },
                    );
                  },
                ),
                _switches(
                  _lactosefree,
                  'Lactose-free',
                  'only include lactose free meals',
                  (newvalue) {
                    setState(
                      () {
                        _lactosefree = newvalue;
                      },
                    );
                  },
                ),
                _switches(
                  _vegetarian,
                  'vegetarian',
                  'only include vegetarian meals',
                  (newvalue) {
                    setState(
                      () {
                        _vegetarian = newvalue;
                      },
                    );
                  },
                ),
                _switches(
                  _vegan,
                  'vegan',
                  'only include vegan meals',
                  (newvalue) {
                    setState(
                      () {
                        _vegan = newvalue;
                      },
                    );
                  },
                ),
              ],
            ))
          ],
        ));
  }
}
