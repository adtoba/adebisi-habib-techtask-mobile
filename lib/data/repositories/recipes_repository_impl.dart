import 'package:dio/dio.dart';
import 'package:tech_task/data/network/http_client.dart';
import 'package:tech_task/domain/constants/endpoints.dart';
import 'package:tech_task/domain/models/recipes_response.dart';
import 'package:tech_task/domain/repositories/recipes_repository.dart';

class RecipesRepositoryImpl extends CustomHttpClient implements RecipesRepository {
  @override
  Future<List<RecipesResponse>> getRecipes({required List<String> ingredients}) async {
    try {
      final res = await http.get(ApiEndpoints.recipies, queryParameters: {
        "ingredients": ingredients.join(",")
      });
      var recipes = res.data as List;

      return List<RecipesResponse>.from(recipes.map((e) 
        => RecipesResponse.fromJson(e)));

    } on DioException {
      rethrow;
    }
  }
}