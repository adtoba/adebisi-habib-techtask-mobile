import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/domain/models/ingredients_response.dart';
import 'package:tech_task/domain/models/recipes_response.dart';
import 'package:tech_task/presentation/utils/random.dart';


void main() {
  test("Generate random string of length n", () {
    var randomString = RandomUtil.generateRandomString(5);
    expect(randomString.length, 5);
  });

  test("Generate random recipes and values not null", () {
    var randomRecipes = RandomUtil.generateRandomRecipes(5);
    expect(randomRecipes.length, 5);
    
    for (RecipesResponse recipe in randomRecipes) {
      expect(recipe.title!.isNotEmpty, true);
      expect(recipe.title!.length, 7);
      expect(recipe.ingredients!.length, 5);
    }
  });

  test("Generate random ingredients and values not null", () {
    var randomIngredients = RandomUtil.generateRandomIngredients(4);
    expect(randomIngredients.length, 4);
    
    for (IngredientsResponse ingredient in randomIngredients) {
      expect(ingredient.title?.isNotEmpty, true);
      expect(ingredient.useBy!.contains("-"), true);
      expect(ingredient.useBy!.length, 10);
    }
  });
}