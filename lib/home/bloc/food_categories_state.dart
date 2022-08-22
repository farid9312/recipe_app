part of 'food_categories_bloc.dart';

abstract class FoodCategoriesState extends Equatable {
  const FoodCategoriesState();

  @override
  List<Object?> get props => [];
}

class FoodCategoriesInitial extends FoodCategoriesState {}

class FoodCategoriesLoading extends FoodCategoriesState {}

class FoodCategoriesLoaded extends FoodCategoriesState {
  const FoodCategoriesLoaded(
    this.categories,
    this.mealInfos,
    this.category,
  );

  final List<FoodCategory> categories;
  final List<FoodInfo> mealInfos;
  final String category;
}

class FoodCategoriesError extends FoodCategoriesState {
  const FoodCategoriesError(this.message);

  final String? message;
}

class MealsByCategoryLoading extends FoodCategoriesState {}

class MealsByCategoryLoaded extends FoodCategoriesState {
  const MealsByCategoryLoaded(
    this.meals,
    this.category,
  );

  final List<FoodInfo> meals;
  final String category;
}
