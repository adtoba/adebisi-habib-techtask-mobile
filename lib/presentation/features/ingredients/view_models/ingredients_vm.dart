import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_task/data/repositories/ingredients_repository_impl.dart';
import 'package:tech_task/domain/models/ingredients_response.dart';
import 'package:tech_task/domain/repositories/ingredients_repository.dart';

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
      errorMessage = _handleException(e);
    }
    return null;
  }

  String _handleException(DioException ex) {
    String message = '';

    if (ex.type == DioExceptionType.connectionError) {
      message = "Ensure you're connected to the internet and try again!";
    } else if(ex.type == DioExceptionType.sendTimeout) {
      message = "Your connection has timed out, try again!";
    } else if(ex.type == DioExceptionType.sendTimeout){
      message = "Your connection has timed out, try again!";
    } else {
      message = "Oops, an error has occured, Please try again";
    }

    return message;
  }
}