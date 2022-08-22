import 'package:json_annotation/json_annotation.dart';

part 'food_info_model.g.dart';

@JsonSerializable()
class FoodInfo {
  const FoodInfo({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
  });

  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  factory FoodInfo.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$FoodInfoFromJson(json);

  Map<String, dynamic> toJson() => _$FoodInfoToJson(this);
}
