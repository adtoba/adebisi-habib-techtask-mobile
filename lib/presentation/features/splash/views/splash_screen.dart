import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tech_task/presentation/features/ingredients/views/ingredients_screen.dart';
import 'package:tech_task/presentation/styles/navigator.dart';
import 'package:tech_task/presentation/styles/palette.dart';
import 'package:tech_task/presentation/utils/dimensions.dart';
import 'package:tech_task/presentation/utils/extensions.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      pushAndReplace(IngredientsScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      backgroundColor: Palette.scaffoldBackgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          "ingredient".png,
          height: config.sh(100),
          width: config.sw(100),
        ),
      ),
    );
  }
}