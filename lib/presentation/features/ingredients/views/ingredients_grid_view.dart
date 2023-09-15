import 'package:flutter/material.dart';
import 'package:tech_task/domain/models/ingredients_response.dart';
import 'package:tech_task/presentation/utils/dimensions.dart';
import 'package:tech_task/presentation/widgets/ingredient_item.dart';


class IngredientsGridView extends StatelessWidget {
  const IngredientsGridView({
    super.key,
    required this.ingredients
  });

  final List<IngredientsResponse> ingredients;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: config.sw(20),
        crossAxisSpacing: config.sh(10)
      ),
      padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        return IngredientItem(
          title: ingredients[index].title,
          date: ingredients[index].useBy,
        );
      }
    );
  }
}