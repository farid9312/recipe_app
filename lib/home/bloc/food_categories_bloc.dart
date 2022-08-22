import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/models/models.dart';

import '../../resources/api_repository.dart';

part 'food_categories_event.dart';
part 'food_categories_state.dart';

class FoodCategoriesBloc
    extends Bloc<FoodCategoriesEvent, FoodCategoriesState> {
  FoodCategoriesBloc() : super(FoodCategoriesInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetFoodCategoriesList>((event, emit) async {
      try {
        emit(FoodCategoriesLoading());

        final categories = await _apiRepository.fetchFoodCategoriesList();

        final meals = await _apiRepository.fetchMealsList(
          category: event.initialSelectedCategory,
        );

        emit(FoodCategoriesLoaded(
          categories,
          meals,
          event.initialSelectedCategory,
        ));
      } on NetworkError {
        emit(const FoodCategoriesError(
            "Failed to fetch data. is your device online?"));
      }
    });

    on<GetMealsByCategoryList>((event, emit) async {
      try {
        emit(MealsByCategoryLoading());

        final meals = await _apiRepository.fetchMealsList(
          category: event.category,
        );

        emit(MealsByCategoryLoaded(
          meals,
          event.category,
        ));
      } on NetworkError {
        emit(const FoodCategoriesError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
