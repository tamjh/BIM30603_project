import 'package:flutter/material.dart';
import 'package:project/core/router/router.dart';
import 'package:project/ui/shared/app_theme.dart';
import 'package:project/ui/shared/size_fit.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize();
    return MaterialApp(
      theme: HYAppTheme.normalTheme,
      initialRoute: HYRouter.initialRoute,
      routes: HYRouter.route,
      onGenerateRoute: HYRouter.generateRoute,
      onUnknownRoute: HYRouter.generateRoute,
    );
  }
}