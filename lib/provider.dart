import 'package:project/core/services/home_service.dart';
import 'package:project/core/services/product_service.dart';
import 'package:project/core/viewmodel/address_view_model.dart';
import 'package:project/core/viewmodel/cart_view_model.dart';
import 'package:project/core/viewmodel/fav_view_model.dart';
import 'package:project/core/viewmodel/home_view_modal.dart';
import 'package:project/core/viewmodel/index_view_model.dart';
import 'package:project/core/viewmodel/order_view_model.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';
import 'package:project/core/viewmodel/search_view_model.dart';
import 'package:project/core/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/services/cart_service.dart';
import 'core/services/order_service.dart';

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
        update: (context, userViewModel, _) {
          // Use the userViewModel's current UID or an empty string
          final uid = userViewModel.currentUser?.uid ?? '';
          print("Updating FavViewModel with UID: $uid");
          return FavViewModel(uid, ProductService());
        },
      ),



      ChangeNotifierProxyProvider2<UserViewModel, ProductViewModel,
          CartViewModel>(
        create: (_) => CartViewModel(
          cartService: CartService(),
          productViewModel: ProductViewModel.all([], ProductService()),
          // Use named constructor here
          uid: '', // Initial empty uid, it will be updated in the update function
          user_name: '',
        ),
        update:
            (context, userViewModel, productViewModel, previousCartViewModel) {
          return CartViewModel(
            cartService: CartService(),
            productViewModel: productViewModel,
            uid: userViewModel.currentUser?.uid ?? '',
            user_name: userViewModel.currentUser?.name ?? '',
          );
        },
      ),


      ChangeNotifierProxyProvider2<CartViewModel, AddressViewModel, OrderViewModel>(
        create: (_) => OrderViewModel(
          orderService: OrderService(),
          cartViewModel: CartViewModel(
            cartService: CartService(),
            productViewModel: ProductViewModel.all([], ProductService()),
            uid: '',
            user_name: '',
          ),
          addressViewModel: AddressViewModel(),
        ),
        update: (_, cartViewModel, addressViewModel, __) {
          return OrderViewModel(
            orderService: OrderService(),
            cartViewModel: cartViewModel,
            addressViewModel: addressViewModel,
          );
        },
      ),


    ];
  }
}
