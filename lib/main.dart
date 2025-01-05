import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/router/router.dart';
import 'package:project/provider.dart';
import 'package:project/ui/shared/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/firebase_options.dart';
import 'package:provider/provider.dart';

import 'core/NavigatorObserver.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsBinding widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  runApp(
    MultiProvider(
      providers: AppProviders.getProviders(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  void initialization() async {
    print('pausing');
    await Future.delayed(const Duration(seconds: 1));
    print('resuming');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey, // Use the global navigatorKey
          navigatorObservers: [CurrentNavigationObserver()],

          debugShowCheckedModeBanner: false,
          theme: HYAppTheme.normalTheme,
          initialRoute: HYRouter.initialRoute,
          routes: HYRouter.route,
          onGenerateRoute: HYRouter.generateRoute,
          onUnknownRoute: HYRouter.generateRoute,
        );
      },
    );
  }
}
