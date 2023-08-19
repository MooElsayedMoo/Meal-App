import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const mealsName = 'category_meals';
  final List<Meal> availableMeals;
  const CategoryMealsScreen( this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String catTitle = '';
  List<Meal>? displayMeal;

  @override
  void didChangeDependencies() {
    final routArg =
    ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final catId = routArg['id'];
    catTitle = routArg['title'].toString();

    displayMeal =
        widget.availableMeals.where((meal) => meal.categories.contains(catId)).toList();
    super.didChangeDependencies();
  }
/*
  WidgetsBinding.instance.addPostFrameCallback((_) async{
});*/



  void _removeMeal(String mealId){
    setState(() {
      displayMeal?.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(catTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeal![index].id,
            imageUrl: displayMeal![index].imageUrl,
            duration: displayMeal![index].duration,
            complexity: displayMeal![index].complexity,
            affordability: displayMeal![index].affordability,
            title: displayMeal![index].title,
          );
        },
        itemCount: displayMeal?.length,
      ),
    );
  }
}
