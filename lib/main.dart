// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:project/core/router/router.dart';
// import 'package:project/ui/shared/app_theme.dart';
// import 'package:firebase_core/firebase_core.dart'; // Add Firebase Core import
// import 'package:project/firebase_options.dart'; // Import the generated firebase_options.dart

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized before Firebase
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       // Design draft size: Adjust to your specific design size.
//       designSize: const Size(360, 800),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: HYAppTheme.normalTheme,
//           initialRoute: HYRouter.initialRoute,
//           routes: HYRouter.route,
//           onGenerateRoute: HYRouter.generateRoute,
//           onUnknownRoute: HYRouter.generateRoute,
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/router/router.dart';
import 'package:project/core/services/home_service.dart';
import 'package:project/core/viewmodel/home_view_modal.dart';
import 'package:project/core/viewmodel/index_view_model.dart';
import 'package:project/core/viewmodel/user_view_model.dart';
import 'package:project/ui/shared/app_theme.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'package:project/firebase_options.dart'; 
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Design draft size: Adjust to your specific design size.
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            // Provide your ViewModel or any other necessary state objects here
            ChangeNotifierProvider(create: (_) => NavigationViewModel()),
            ChangeNotifierProvider(create: (_) => UserViewModel()),
            ChangeNotifierProvider(create: (_) => HomeViewModel(HomeServicesImpl())),
          ],
          child: MaterialApp(
            
            debugShowCheckedModeBanner: false,
            theme: HYAppTheme.normalTheme,
            initialRoute: HYRouter.initialRoute,
            routes: HYRouter.route,
            onGenerateRoute: HYRouter.generateRoute,
            onUnknownRoute: HYRouter.generateRoute,
          ),
        );
      },
    );
  }
}
