import 'package:json_annotation/json_annotation.dart';

part 'food_category_model.g.dart';

@JsonSerializable()
class FoodCategory {
  const FoodCategory({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  factory FoodCategory.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$FoodCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$FoodCategoryToJson(this);
}
