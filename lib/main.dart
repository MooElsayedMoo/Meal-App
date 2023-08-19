import 'package:flutter/material.dart';
import 'package:meal_app_n/dummy_data.dart';
import 'models/meal.dart';
import 'screens/filter_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/meal_detail_screen.dart';
import '../screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;

      availableMeals.where((meal) {
        if(_filters['gluten']! && meal.isGlutenFree == false)
          {
            return false;
          }
        if(_filters['lactose']!&& meal.isLactoseFree == false)
        {
          return false;
        }
        if(_filters['vegan']! && meal.isVegan == false)
        {
          return false;
        }
        if(_filters['vegetarian']! && meal.isVegetarian == false)
        {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
    //if true return mealId else return -1.
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >=0){
    setState(() {
      favoriteMeals.removeAt(existingIndex);
    });
    }
    else{
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavorite(String id){
    return favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 299, 1),
        useMaterial3: true,
        textTheme: ThemeData
            .light()
            .textTheme
            .copyWith(
          bodyLarge: const TextStyle(
            color: Color.fromRGBO(20, 50, 50, 1),
          ),
          bodyMedium: const TextStyle(
            color: Color.fromRGBO(20, 50, 50, 1),
          ),
          titleLarge: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //home: const CategoriesScreen(),
      routes: {
        '/': (context) =>  TabsScreen(favoriteMeals),
        CategoryMealsScreen.mealsName: (context) =>  CategoryMealsScreen( availableMeals),
        MealDetailsScreen.detailRoute: (context) =>  MealDetailsScreen(_toggleFavorite, _isFavorite),
        FiltersScreen.routeName: (context) =>  FiltersScreen(_setFilters, _filters),
      },
    );
  }
}
