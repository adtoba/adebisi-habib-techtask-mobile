import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_task/domain/models/ingredients_response.dart';
import 'package:tech_task/presentation/features/ingredients/view_models/ingredients_vm.dart';
import 'package:tech_task/presentation/utils/dimensions.dart';
import 'package:tech_task/presentation/widgets/ingredient_item.dart';


class IngredientsGridView extends ConsumerWidget {
  const IngredientsGridView({
    super.key,
    required this.ingredients
  });

  final List<IngredientsResponse> ingredients;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = SizeConfig();
    var ingredientsProvider = ref.watch(ingredientsViewModel);

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
          onTap: () {
            String? useBy = ingredients[index].useBy;
            DateTime selectedDate = ingredientsProvider.selectedDate;
            DateTime useByDate = DateTime.parse(useBy!);
            
            String formattedSelectedDate = selectedDate.toString().split(" ").first;
            String formattedUseByDate = useByDate.toString().split(" ").first;

            bool sameYearMonthDay = formattedUseByDate == formattedSelectedDate;

            if(!useByDate.isAfter(selectedDate) && !sameYearMonthDay) {
              ingredientsProvider.addIngredient(ingredients[index].title);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(
                  "You cannot select this recipient because the selected date is past its use date"
                ))
              );
            }
          },
          isSelected: ingredientsProvider.selectedIngredients
            .contains(ingredients[index].title)
        );
      }
    );
  }
}