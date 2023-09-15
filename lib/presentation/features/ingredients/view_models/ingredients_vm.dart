import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_task/data/repositories/ingredients_repository_impl.dart';
import 'package:tech_task/domain/models/ingredients_response.dart';
import 'package:tech_task/domain/repositories/ingredients_repository.dart';
import 'package:tech_task/presentation/utils/error_handler.dart';

final ingredientsViewModel = ChangeNotifierProvider<IngredientsViewModel>((ref) {
  return IngredientsViewModel();
});

class IngredientsViewModel extends ChangeNotifier {
  late IngredientsRepository repo;

  IngredientsViewModel() {
    repo = IngredientRepositoryImpl();
  }
  String errorMessage = "Oops, an error has occured, Please try again!";

  Future<List<IngredientsResponse>?> getIngredients() async {
    errorMessage = "";

    try {
      final response = await repo.getIngredients();
      return response;
    } on DioException catch (e) {
      errorMessage = CustomErrorHandler.handleException(e);
    }
    return null;
  }

  
}