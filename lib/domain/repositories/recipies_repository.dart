import 'package:tech_task/domain/models/recipies_response.dart';

abstract class RecipiesRepository {
  Future<List<RecipiesResponse>> getRecipies({required List<String> ingredients});
}