import 'package:recipe_app/models/models.dart';
import 'package:recipe_app/resources/api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<FoodCategory>> fetchFoodCategoriesList() async {
    final result = await _provider.fetchFoodCategoriesList();

    return result;
  }

  Future<List<FoodInfo>> fetchMealsList({
    required String category,
  }) async {
    final result = await _provider.mealsList(category: category);

    return result;
  }

  Future<Food?> fetchMealDetails({
    required String mealId,
  }) async {
    final result = await _provider.mealDetails(mealId: mealId);

    return result;
  }
}

class NetworkError extends Error {}
