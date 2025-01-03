import 'package:flutter/material.dart';
import 'package:project/ui/pages/cart/cart.dart';
import 'package:project/ui/pages/favourite/fav.dart';
import 'package:project/ui/pages/home/home.dart';
import 'package:project/ui/pages/shop/shop.dart';

final List<Widget> pages = [
  HYHomeScreen(),
  FavouriteScreen(),
  ShopScreen(),
  CartScreen(),
];

final List<BottomNavigationBarItem> items = [
  buildBottomNavItem(Icons.home_outlined, "Home", Icons.home),
  buildBottomNavItem(Icons.favorite_outline, "Favourite", Icons.favorite),
  buildBottomNavItem(Icons.trolley, "Shop", Icons.trolley),
  buildBottomNavItem(Icons.shopping_bag_outlined, "Cart", Icons.shopping_bag),
];

BottomNavigationBarItem buildBottomNavItem(
    IconData unselected, String title, IconData selected) {
  return BottomNavigationBarItem(
    icon: Icon(unselected),
    label: title,
    activeIcon: Icon(selected),
  );
}
