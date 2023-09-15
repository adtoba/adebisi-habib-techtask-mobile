import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_task/domain/models/ingredients_response.dart';
import 'package:tech_task/presentation/features/ingredients/view_models/ingredients_vm.dart';
import 'package:tech_task/presentation/features/ingredients/views/ingredients_grid_view.dart';
import 'package:tech_task/presentation/styles/palette.dart';
import 'package:tech_task/presentation/styles/textstyles.dart';
import 'package:tech_task/presentation/utils/dimensions.dart';
import 'package:tech_task/presentation/utils/extensions.dart';
import 'package:tech_task/presentation/widgets/ingredient_item.dart';


class IngredientsScreen extends ConsumerStatefulWidget {
  const IngredientsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends ConsumerState<IngredientsScreen> {

  DateTime selectedDate = DateTime.now();

  final controller = TextEditingController();

  late final Future future = ref.read(ingredientsViewModel).getIngredients();

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

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
      ),
      body: Container(
        child: FutureBuilder(
          future: future, 
          builder: ((context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              var ingredients = snapshot.data as List<IngredientsResponse>;

              return IngredientsGridView(
                ingredients: ingredients
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator()
              );
            } else {
              return Center(
                child: Text(
                  "Failed to load ingredients"
                ),
              );
            }
          })
        )
      ),
      // bottomSheet: BottomSheet(
      //   onClosing: () {},
      //   backgroundColor: Palette.lightPurple,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(20),
      //       topRight: Radius.circular(20),
      //     )
      //   ),
      //   builder: (context) {
      //     return Container(
      //       padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(20)),
      //       height: config.sh(300),
      //       width: double.infinity,
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             "Select lunch date",
      //             style: CustomTextStyles.bold16,
      //           ),
      //           SizedBox(height: config.sh(20)),
      //           InkWell(
      //             onTap: () async {
      //               final picked = await showDatePicker(
      //                 context: context, 
      //                 initialDate: selectedDate, 
      //                 firstDate: DateTime.now(),
      //                 lastDate: DateTime(2101)
      //               );

      //               if (picked != null) {
      //                 setState(() {
      //                   selectedDate = picked;
      //                   controller.text = selectedDate.toString().split(" ").first;
      //                 });
      //               }
      //             },
      //             child: TextFormField(
      //               controller: controller,
      //               decoration: InputDecoration(
      //                 prefixIcon: Icon(Icons.calendar_today),
      //                 hintText: "Pick a date",
      //                 enabled: false,
      //                 border: OutlineInputBorder()
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     );
      //   }
      // ),
    );
  }
}