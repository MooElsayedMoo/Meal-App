import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(this.saveFilters, this.currentFilters);
  static const routeName = '/filter';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {
     _glutenFree = widget.currentFilters['gluten']!;
     _lactoseFree = widget.currentFilters['lactose']!;
     _vegan = widget.currentFilters['vegan']!;
     _vegetarian = widget.currentFilters['vegetarian']!;

    super.initState();
  }

  SwitchListTile buildSwitchListTile(
      {required String title,
      required String subTitle,
      required bool currentVal,
      required Function updateValue}) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: currentVal,
      onChanged: updateValue as void Function(bool?)?,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
        actions: [
          IconButton(
              onPressed: () {
                final Map<String, bool> selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian
                };
                widget.saveFilters(selectedFilters);
              },
              icon:const Icon(Icons.save),),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  title: 'Gluten Free',
                  subTitle: 'Only include gluten-free meals',
                  currentVal: _glutenFree,
                  updateValue: (newVal) {
                    setState(() {
                      _glutenFree = newVal;
                    });
                  },
                ),
                buildSwitchListTile(
                  title: 'Lactose Free',
                  subTitle: 'Only include lactose-free meals',
                  currentVal: _lactoseFree,
                  updateValue: (newVal) {
                    setState(() {
                      _lactoseFree = newVal;
                    });
                  },
                ),
                buildSwitchListTile(
                  title: 'Vegan',
                  subTitle: 'Only include Vegan meals',
                  currentVal: _vegan,
                  updateValue: (newVal) {
                    setState(() {
                      _vegan = newVal;
                    });
                  },
                ),
                buildSwitchListTile(
                  title: 'Vegetarian',
                  subTitle: 'Only include Vegetarian meals',
                  currentVal: _vegetarian,
                  updateValue: (newVal) {
                    setState(() {
                      _vegetarian = newVal;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
