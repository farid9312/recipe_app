import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/models.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _foodCategoriesUrl =
      'https://www.themealdb.com/api/json/v1/1/categories.php';
  final String _mealsUrl =
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=';
  final String _mealDetailsUrl =
      'https://www.themealdb.com/api/json/v1/1/lookup.php?i=';

  Future<List<FoodCategory>> fetchFoodCategoriesList() async {
    try {
      Response response = await _dio.get(_foodCategoriesUrl);

      final data = response.data["categories"];

      final list = List<FoodCategory>.from(
          data.map((item) => FoodCategory.fromJson(item))).toList();

      return list;
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return [];
    }
  }

  Future<List<FoodInfo>> mealsList({
    required String category,
  }) async {
    try {
      Response response = await _dio.get(_mealsUrl + category);

      final data = response.data["meals"];

      final list =
          List<FoodInfo>.from(data.map((item) => FoodInfo.fromJson(item)))
              .toList();

      return list;
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return [];
    }
  }

  Future<Food?> mealDetails({
    required String mealId,
  }) async {
    try {
      Response response = await _dio.get(_mealDetailsUrl + mealId);

      final data = Food.fromJson(response.data["meals"][0]);

      return data;
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return null;
    }
  }
}
