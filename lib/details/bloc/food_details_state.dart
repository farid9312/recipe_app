part of 'food_details_bloc.dart';

abstract class FoodDetailsState extends Equatable {
  const FoodDetailsState();

  @override
  List<Object> get props => [];
}

class FoodDetailsInitial extends FoodDetailsState {}

class FoodDetailsLoading extends FoodDetailsState {}

class FoodDetailsLoaded extends FoodDetailsState {
  const FoodDetailsLoaded({
    this.meal,
  });

  final Food? meal;
}

class FoodDetailsError extends FoodDetailsState {
  const FoodDetailsError(this.message);

  final String? message;
}
