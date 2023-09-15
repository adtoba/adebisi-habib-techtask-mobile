import 'package:tech_task/domain/models/ingredients_response.dart';

abstract class IngredientsRepository {
  Future<List<IngredientsResponse>> getIngredients();
}