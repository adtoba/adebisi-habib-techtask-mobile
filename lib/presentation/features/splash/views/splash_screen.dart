import 'package:flutter/material.dart';
import 'package:tech_task/presentation/styles/palette.dart';
import 'package:tech_task/presentation/utils/extensions.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffoldBackgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          "ingredient".png
        ),
      ),
    );
  }
}