import 'package:flutter/material.dart';
import 'package:tech_task/presentation/features/splash/views/splash_screen.dart';
import 'package:tech_task/presentation/utils/dimensions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(builder: (context) {
        SizeConfig.init(context);
        return SplashScreen();
      })
    );
  }
}

