import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_task/data/repositories/ingredients_repository_impl.dart';
import 'package:tech_task/domain/models/ingredients_response.dart';
import 'package:tech_task/domain/repositories/ingredients_repository.dart';
import 'package:tech_task/presentation/styles/textstyles.dart';
import 'package:tech_task/presentation/utils/dimensions.dart';
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

  DateTime selectedDate = DateTime.now();

  List<String> selectedIngredients = [];

  void addIngredient(String? ingredient) {
    if(!selectedIngredients.contains(ingredient)) {
      selectedIngredients.add(ingredient!);
    } else {
      selectedIngredients.remove(ingredient);
    }
    notifyListeners();
  }

  void clear() {
    selectedIngredients.clear();
    notifyListeners();
  }

  bool compareUseByAndSelectedDate(DateTime useBy) {
    if(selectedDate.isBefore(useBy) || useBy.isAtSameMomentAs(selectedDate)) {
      return false;
    } else {
      return true;
    }
  }

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


  void pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context, 
      initialDate: selectedDate, 
      firstDate: DateTime(2001),
      lastDate: DateTime(2101),
      helpText: "Select a lunch date".toUpperCase(),
    );

    if (picked != null) {
      selectedDate = picked;
      clear();
      notifyListeners();
    }
  }
}