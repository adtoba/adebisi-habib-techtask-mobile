import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_task/data/repositories/recipes_repository_impl.dart';
import 'package:tech_task/domain/models/recipes_response.dart';
import 'package:tech_task/domain/repositories/recipes_repository.dart';
import 'package:tech_task/presentation/features/ingredients/view_models/ingredients_vm.dart';
import 'package:tech_task/presentation/utils/error_handler.dart';

final recipesViewModel = ChangeNotifierProvider<RecipesViewModel>((ref) {
  return RecipesViewModel(ref);
});

class RecipesViewModel extends ChangeNotifier {
  late RecipesRepository repo;
  late ChangeNotifierProviderRef ref;

  RecipesViewModel(this.ref) {
    repo = RecipesRepositoryImpl();
  }
  String errorMessage = "Oops, an error has occured, Please try again!";

  Future<List<RecipesResponse>?> getRecipes() async {
    errorMessage = "";

    try {
      var ingredients = ref.watch(ingredientsViewModel).selectedIngredients;

      final response = await repo.getRecipes(
        ingredients: ingredients
      );

      return response;
    } on DioException catch (e) {
      errorMessage = CustomErrorHandler.handleException(e);
    }
    return null;
  }
}