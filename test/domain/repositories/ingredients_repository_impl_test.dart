import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/data/repositories/ingredients_repository_impl.dart';
import 'package:tech_task/domain/models/ingredients_response.dart';
import 'package:tech_task/domain/repositories/ingredients_repository.dart';


void main() {
  late IngredientsRepository _ingredientsRepo;

  setUpAll(() {
    _ingredientsRepo = IngredientRepositoryImpl();
  });

  test("Fetch ingredients from server", () async {
    final response = await _ingredientsRepo.getIngredients();
    expect(response, isA<List<IngredientsResponse>>());
    expect(response.length, isNonZero);
  });
}