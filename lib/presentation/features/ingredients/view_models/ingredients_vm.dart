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
      lastDate: DateTime(2101)
    );

    if (picked != null) {
      selectedDate = picked;
      Navigator.pop(context);
      clear();
      notifyListeners();
    }
  }

  void showPickerDialog(BuildContext context) {
    final config = SizeConfig();

    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Color(0xff280071),
            title: Text(
              "Select Lunch Date",
              style: CustomTextStyles.bold16.copyWith(
                color: Colors.white,
                fontSize: config.sp(20)
              ),
            ),
            content: InkWell(
              onTap: () => pickDate(context),
              child: Container(
                height: config.sh(45),
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
                child: Row(
                  children: [
                    Text(
                      "${selectedDate.toString().split(" ").first}",
                      style: CustomTextStyles.normal14.copyWith(
                        color: Colors.white
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey
                  )
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      }
    );
  }

  
}