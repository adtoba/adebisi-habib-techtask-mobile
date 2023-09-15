import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/data/repositories/ingredients_repository_impl.dart';
import 'package:tech_task/data/repositories/recipes_repository_impl.dart';
import 'package:tech_task/domain/models/ingredients_response.dart';
import 'package:tech_task/domain/models/recipes_response.dart';
import 'package:tech_task/domain/repositories/ingredients_repository.dart';
import 'package:tech_task/domain/repositories/recipes_repository.dart';

void main() {
  late RecipesRepository _recipesRepository;
  late IngredientsRepository _ingredientsRepo;

  setUpAll(() {
    _recipesRepository = RecipesRepositoryImpl();
    _ingredientsRepo = IngredientRepositoryImpl();
  });

  test("throws assertion error when recipies has empty ingredients", () async {
    try {
      await _recipesRepository.getRecipes(ingredients: []);
    } catch (e) {
      expect(e, isA<AssertionError>());
    }
  });
  

  test("fetch recipies from server", () async {
    final ingredients = await _ingredientsRepo.getIngredients();

    List<String?> query = ingredients.map((element) {
        return element.title;
      }).toList();

    final recipies = await _recipesRepository.getRecipes(
      ingredients: query
    );
    
    expect(recipies, isA<List<RecipesResponse>>());
    expect(ingredients, isA<List<IngredientsResponse>>());
  });
}