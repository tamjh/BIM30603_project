import 'package:flutter/material.dart';
import 'package:project/core/viewmodel/index_view_model.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:project/ui/pages/main/initialized.dart';  // Import pages

class HYMainScreen extends StatelessWidget {
  static final String routeName = "/";
  const HYMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationViewModel(),  // Provide the NavigationViewModel
      child: Consumer<NavigationViewModel>(
        builder: (context, navigationViewModel, child) {
          return Scaffold(
            body: IndexedStack(
              index: navigationViewModel.currentIndex, // Use ViewModel's currentIndex
              children: pages, // Your pages list
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: items, // Define your bottom nav items
              currentIndex: navigationViewModel.currentIndex,  // Bind to the ViewModel
              selectedFontSize: 14,
              unselectedFontSize: 14,
              onTap: (value) {
                navigationViewModel.setCurrentIndex(value);  // Update index using ViewModel
              },
            ),
          );
        },
      ),
    );
  }
}
