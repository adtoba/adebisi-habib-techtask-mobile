import 'package:flutter/material.dart';
import 'package:tech_task/presentation/styles/textstyles.dart';
import 'package:tech_task/presentation/utils/dimensions.dart';
import 'package:tech_task/presentation/utils/extensions.dart';


class IngredientItem extends StatelessWidget {
  const IngredientItem({
    super.key,
    this.title,
    this.date,
    this.isSelected = false,
    this.onTap
  });

  final String? title;
  final String? date;
  final bool? isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "ingredient".png,
                  height: config.sh(30),
                  width: config.sw(30),
                ),
                SizedBox(height: config.sh(5)),
                Text(
                  "$title",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.bold14.copyWith(
                    color: Colors.white
                  ),
                ),
                SizedBox(height: config.sh(10)),
                Text(
                  "$date",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.normal12.copyWith(
                    color: Colors.grey
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff280071)
            ),
          ),
    
          if(isSelected!)...[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                child: Icon(
                  Icons.check, 
                  color: Colors.green,
                  size: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(.5)
                ),
              ),
            )
          ]
          
        ],
      ),
    );
  }
}