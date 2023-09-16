import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_task/domain/models/recipes_response.dart';
import 'package:tech_task/presentation/features/recipes/view_models/recipes_vm.dart';
import 'package:tech_task/presentation/styles/palette.dart';
import 'package:tech_task/presentation/styles/textstyles.dart';
import 'package:tech_task/presentation/utils/dimensions.dart';
import 'package:tech_task/presentation/widgets/recipe_item.dart';
import 'package:tech_task/presentation/widgets/retry_widget.dart';

class RecipesScreen extends ConsumerStatefulWidget {
  const RecipesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends ConsumerState<RecipesScreen> {

  late Future<List<RecipesResponse>?> recipes;
  
  @override
  void initState() {
    recipes = ref.read(recipesViewModel).getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var recipesProvider = ref.watch(recipesViewModel);

    return Scaffold(
      backgroundColor: Palette.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.5,
        backgroundColor: Palette.scaffoldBackgroundColor,
        title: Text(
          "Recipes".toUpperCase(),
          style: CustomTextStyles.bold16.copyWith(
            fontSize: config.sp(20),
            color: Colors.white
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
        child: Column(
          children: [
            SizedBox(height: config.sh(20)),
            FutureBuilder<List<RecipesResponse>?>(
              future: recipes,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.hasData) {
                    var recipes = snapshot.data as List<RecipesResponse>;
                    return ListView.separated(
                      itemCount: recipes.length,
                      shrinkWrap: true,
                      itemBuilder: (c, i) {
                        return RecipeItem(
                          title: recipes[i].title ?? "",
                          ingredients: recipes[i].ingredients?.join(", ") ?? "",
                        );
                      },
                      separatorBuilder: (c, i) => SizedBox(height: config.sh(10)),
                    );
                  } else {
                    return RetryWidget(
                      errorMessage: recipesProvider.errorMessage,
                      onPressed: () {
                        setState(() {
                          recipes = recipesProvider.getRecipes();
                        });
                      },
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator()
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}