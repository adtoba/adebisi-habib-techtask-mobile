import 'package:tech_task/domain/models/recipes_response.dart';

abstract class RecipesRepository {
  Future<List<RecipesResponse>> getRecipies({required List<String> ingredients});
}