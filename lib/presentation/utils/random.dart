import 'dart:math';

import 'package:tech_task/domain/models/ingredients_response.dart';
import 'package:tech_task/domain/models/recipes_response.dart';

class RandomUtil {
  static var rand = Random();

  static String generateRandomString(int length) {  
    return String.fromCharCodes(List.generate(length, (index) 
      => rand.nextInt(33) + 89));
  }

  static List<IngredientsResponse> generateRandomIngredients(int length) {
    List<IngredientsResponse> result = [];

    for (int i = 0; i < length; i++) {
      result.add(IngredientsResponse(
        title: generateRandomString(6),
        useBy: generateRandomString(10),
      ));
    }
    return result;
  }

  static List<RecipesResponse> generateRandomRecipes(int length) {
    List<RecipesResponse> result = [];

    for (int i = 0; i < length; i++) {
      result.add(RecipesResponse(
        title: generateRandomString(7),
        ingredients: List.generate(5, (index) => generateRandomString(10)),
      ));
    }

    return result;
  }
}