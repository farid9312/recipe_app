import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/models/models.dart';
import 'package:recipe_app/resources/api_repository.dart';

part 'food_details_event.dart';
part 'food_details_state.dart';

class FoodDetailsBloc extends Bloc<FoodDetailsEvent, FoodDetailsState> {
  FoodDetailsBloc() : super(FoodDetailsInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetFoodDetails>((event, emit) async {
      try {
        emit(FoodDetailsLoading());

        final meal = await _apiRepository.fetchMealDetails(
          mealId: event.mealId,
        );

        emit(FoodDetailsLoaded(
          meal: meal,
        ));
      } on NetworkError {
        emit(const FoodDetailsError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
