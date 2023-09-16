import 'package:flutter/material.dart';
import 'package:tech_task/presentation/styles/textstyles.dart';
import 'package:tech_task/presentation/utils/dimensions.dart';
import 'package:tech_task/presentation/utils/extensions.dart';


class RecipeItem extends StatelessWidget {
  const RecipeItem({super.key, this.title, this.ingredients});

  final String? title;
  final String? ingredients;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    
    return ListTile(
      leading: Image.asset(
        "recipe".png,
        height: config.sh(40),
        width: config.sw(40),
      ),
      title: Text(
        "$title",
        style: CustomTextStyles.bold16.copyWith(
          color: Colors.white,
          fontSize: config.sp(18)
        ),
      ),
      subtitle: Text(
        "$ingredients",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      tileColor: Color(0xff280071),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}