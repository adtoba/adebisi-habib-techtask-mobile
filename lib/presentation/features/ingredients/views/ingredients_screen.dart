import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_task/domain/models/ingredients_response.dart';
import 'package:tech_task/presentation/features/ingredients/view_models/ingredients_vm.dart';
import 'package:tech_task/presentation/features/ingredients/views/ingredients_grid_view.dart';
import 'package:tech_task/presentation/features/recipes/view_models/recipes_vm.dart';
import 'package:tech_task/presentation/features/recipes/views/recipes_screen.dart';
import 'package:tech_task/presentation/styles/navigator.dart';
import 'package:tech_task/presentation/styles/palette.dart';
import 'package:tech_task/presentation/styles/textstyles.dart';
import 'package:tech_task/presentation/utils/dimensions.dart';
import 'package:tech_task/presentation/utils/extensions.dart';
import 'package:tech_task/presentation/widgets/ingredient_item.dart';
import 'package:tech_task/presentation/widgets/retry_widget.dart';


class IngredientsScreen extends ConsumerStatefulWidget {
  const IngredientsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends ConsumerState<IngredientsScreen> {

  DateTime selectedDate = DateTime.now();

  final controller = TextEditingController();

  late Future<List<IngredientsResponse>?> _ingredients;

  @override
  void initState() {
    super.initState();
    _ingredients = ref.read(ingredientsViewModel).getIngredients();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ingredientsViewModel).pickDate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var ingredientsProvider = ref.watch(ingredientsViewModel);
    String selectedDate = ingredientsProvider.selectedDate.toString();

    return Scaffold(
      backgroundColor: Palette.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Palette.scaffoldBackgroundColor,
        elevation: 1,
        title: Text(
          "Ingredients".toUpperCase(),
          style: CustomTextStyles.bold16.copyWith(
            fontSize: config.sp(20),
            color: Colors.white
          ),
        ),
        actions: [
          Row(
            children: [
              Text(
                "${selectedDate.split(" ").first}",
                style: CustomTextStyles.normal12.copyWith(
                  color: Colors.white
                ),
              ),
              IconButton(
                onPressed: () {
                  ingredientsProvider.pickDate(context);
                }, 
                icon: Icon(Icons.calendar_today)
              ),
            ],
          )
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: config.sh(20)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
              child: Text(
                "Select ingredients to see available recipes",
                style: CustomTextStyles.normal14.copyWith(
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(height: config.sh(10)),
            Expanded(
              child: FutureBuilder<List<IngredientsResponse>?>(
                future: _ingredients, 
                builder: ((context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
            
                    if(snapshot.hasData) {
                      var ingredients = snapshot.data as List<IngredientsResponse>;
            
                      return IngredientsGridView(
                        ingredients: ingredients
                      );
            
                    } else {
                      return RetryWidget(
                        errorMessage: ingredientsProvider.errorMessage,
                        onPressed: () {
                          setState(() {
                            _ingredients = ref.read(ingredientsViewModel)
                                .getIngredients();
                          });
                        },
                      );
                    } 
                  } else {
                    return Center(
                      child: CircularProgressIndicator()
                    );
                  } 
                })
              ),
            ),
          ],
        )
      ),
      floatingActionButton: Visibility(
        visible: ingredientsProvider.selectedIngredients.isNotEmpty,
        child: FloatingActionButton(
          child: Icon(Icons.arrow_forward),
          onPressed: () {
            push(RecipesScreen());
          },
        ),
      ),
    );
  }
}