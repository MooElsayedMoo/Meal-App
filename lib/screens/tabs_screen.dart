import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import 'favourite_screen.dart';
import 'categories_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabsScreen(this.favoriteMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
   List<Map<String, Object>>? _pages ;

  int _selectedPageIndex = 0;
  void _selectPage(int value){
setState(() {
  _selectedPageIndex = value;
});
}

@override
  void initState() {
    _pages = [
      {
        'page' : const CategoriesScreen(),
        'title' : 'Categories',
      },
      {
        'page' :  FavouriteScreen(widget.favoriteMeals),
        'title' : 'Your Favourites',
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_pages![_selectedPageIndex]['title']}'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).canvasColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items:const [
           BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favourite",
          ),
        ],
      ),
      body: _pages![_selectedPageIndex]['page'] as Widget,
      drawer: const MainDrawer(),
    );
  }
}
