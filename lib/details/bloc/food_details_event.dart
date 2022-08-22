part of 'food_details_bloc.dart';

abstract class FoodDetailsEvent extends Equatable {
  const FoodDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetFoodDetails extends FoodDetailsEvent {
  const GetFoodDetails({
    required this.mealId,
  });

  final String mealId;
}
