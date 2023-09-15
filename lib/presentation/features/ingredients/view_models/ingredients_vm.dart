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

  bool _getIngredientsBusy = false;
  bool get getIngredientsBusy => _getIngredientsBusy;

  Future<List<IngredientsResponse>?> getIngredients() async {
    _getIngredientsBusy = true;
    notifyListeners();

    try {
      final response = await repo.getIngredients();
      return response;
    } catch (e) {
      return null;
    } finally {
      _getIngredientsBusy = false;
      notifyListeners();
    }
  }
}