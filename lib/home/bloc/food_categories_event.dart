part of 'food_categories_bloc.dart';

abstract class FoodCategoriesEvent extends Equatable {
  const FoodCategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetFoodCategoriesList extends FoodCategoriesEvent {
  const GetFoodCategoriesList({
    this.initialSelectedCategory = 'Chicken',
  });

  final String initialSelectedCategory;
}

class GetMealsByCategoryList extends FoodCategoriesEvent {
  const GetMealsByCategoryList({
    required this.category,
  });

  final String category;
}
