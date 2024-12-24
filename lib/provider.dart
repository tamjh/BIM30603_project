import 'package:project/core/services/home_service.dart';
import 'package:project/core/services/product_service.dart';
import 'package:project/core/viewmodel/address_view_model.dart';
import 'package:project/core/viewmodel/cart_view_model.dart';
import 'package:project/core/viewmodel/fav_view_model.dart';
import 'package:project/core/viewmodel/home_view_modal.dart';
import 'package:project/core/viewmodel/index_view_model.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';
import 'package:project/core/viewmodel/search_view_model.dart';
import 'package:project/core/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/services/cart_service.dart';

class AppProviders {
  static List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider(create: (_) => UserViewModel()),
      ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ChangeNotifierProvider(create: (_) => AddressViewModel()),
      ChangeNotifierProvider(create: (_) => SearchViewModel()),
      ChangeNotifierProvider(
        create: (_) => HomeViewModel(
          HomeServicesImpl(),
          ProductService(),
          UserViewModel(),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductViewModel.all([], ProductService()),
      ),
      ChangeNotifierProxyProvider<UserViewModel, FavViewModel>(
        create: (_) => FavViewModel('', ProductService()),
        update: (context, userViewModel, previousFavViewModel) {
          return FavViewModel(
            userViewModel.currentUser?.uid ?? '',
            ProductService(),
          );
        },
      ),
      ChangeNotifierProxyProvider2<UserViewModel, ProductViewModel,
          CartViewModel>(
        create: (_) => CartViewModel(
          cartService: CartService(),
          productViewModel: ProductViewModel.all([], ProductService()),
          // Use named constructor here
          uid:
              '', // Initial empty uid, it will be updated in the update function
        ),
        update:
            (context, userViewModel, productViewModel, previousCartViewModel) {
          return CartViewModel(
            cartService: CartService(),
            productViewModel: productViewModel,
            uid: userViewModel.currentUser?.uid ?? '',
          );
        },
      ),
    ];
  }
}
