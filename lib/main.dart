import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_task/presentation/features/splash/views/splash_screen.dart';
import 'package:tech_task/presentation/utils/dimensions.dart';

void main() => runApp(ProviderScope(child: MyApp()));

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme()
      ),
      navigatorKey: navigatorKey,
      home: Builder(builder: (context) {
        SizeConfig.init(context);
        return SplashScreen();
      })
    );
  }
}

