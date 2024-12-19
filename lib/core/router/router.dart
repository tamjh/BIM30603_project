import 'package:flutter/material.dart';
import 'package:project/ui/pages/cart/cart.dart';
import 'package:project/ui/pages/edit_address/edit_address.dart';
import 'package:project/ui/pages/home/home.dart';
import 'package:project/ui/pages/login/login.dart';
import 'package:project/ui/pages/main/main.dart';
import 'package:project/ui/pages/order_history/order_history.dart';
import 'package:project/ui/pages/payment/payment.dart';
import 'package:project/ui/pages/product_detail/product_detail.dart';
import 'package:project/ui/pages/register/register.dart';
import 'package:project/ui/pages/search/search.dart';
import 'package:project/ui/pages/shipping_info/shipping_info.dart';
import 'package:project/ui/pages/shop/shop.dart';

class HYRouter {
  static final String initialRoute = HYLogin.routeName;
  
  static final Map<String, WidgetBuilder> route = {
    HYLogin.routeName: (ctx) => HYLogin(),
    HYRegister.routeName: (ctx) => HYRegister(),
    HYMainScreen.routeName: (ctx) => HYMainScreen(),
    HYHomeScreen.routeName: (ctx) => HYHomeScreen(),
    SearchScreen.routeName: (ctx) => SearchScreen(),
    CartScreen.routeName: (ctx) => CartScreen(),
    OrderHistory.routeName: (ctx) => OrderHistory(),
    ShippingInfoScreen.routeName: (ctx) => ShippingInfoScreen(),
    EditAddress.routeName: (ctx) => EditAddress(),
    PaymentScreen.routeName: (ctx) => PaymentScreen(),
    ShopScreen.routeName: (ctx) => ShopScreen(),
    ProductDetailScreen.routeName: (ctx) => ProductDetailScreen()
  };

  static final RouteFactory generateRoute = (settings) => null;

  static final RouteFactory unknownRoute = (settings) => MaterialPageRoute(
        builder: (ctx) => Scaffold(
          body: Center(child: Text("Unknown Route")),
        ),
      );
}
