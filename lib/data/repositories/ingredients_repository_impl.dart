import 'package:dio/dio.dart';
import 'package:tech_task/data/network/http_client.dart';
import 'package:tech_task/domain/constants/endpoints.dart';
import 'package:tech_task/domain/models/ingredients_response.dart';
import 'package:tech_task/domain/repositories/ingredients_repository.dart';

class IngredientRepositoryImpl extends CustomHttpClient implements IngredientsRepository {
  @override
  Future<List<IngredientsResponse>> getIngredients() async {
    try {
      final res = await http.get(ApiEndpoints.ingredients);
      var ingredients = res.data as List;

      return List<IngredientsResponse>.from(
        ingredients.map((e) => IngredientsResponse.fromJson(e)));
    } on DioException {
      rethrow;
    }
  }
}