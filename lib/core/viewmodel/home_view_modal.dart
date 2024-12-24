// home_view_model.dart
import 'package:flutter/material.dart';
import 'package:project/core/model/fav_model.dart';
import 'package:project/core/services/home_service.dart';
import 'package:project/core/services/product_service.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';
import 'package:project/core/viewmodel/user_view_model.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeService _service;
  final ProductService _productService;
  final UserViewModel _userViewModel;

  List<ProductViewModel> hotProducts = [];
  List<ProductViewModel> newProducts = [];
  bool isLoading = false;

  HomeViewModel(this._service, this._productService, this._userViewModel);

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      final hotProductsData = await _service.getHotProducts();
      final newProductsData = await _service.getNewProducts();

      hotProducts = hotProductsData
          .map((p) => ProductViewModel.single(p, _productService))
          .toList();
      newProducts = newProductsData
          .map((p) => ProductViewModel.single(p, _productService))
          .toList();

      if (_userViewModel.currentUser == null) {
        // Handle the case when currentUser is null
        //print('From home vm: User is not logged in');
        return;
      }

      final favItems =
          await _productService.getFavItems(_userViewModel.currentUser!.uid);

      _markFavouriteProducts(hotProducts, favItems);
      _markFavouriteProducts(newProducts, favItems);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Mark products as favourite
  void _markFavouriteProducts(
      List<ProductViewModel> products, List<Favourite> favItems) {
    for (var product in products) {
      product.isFavourite = favItems.any((fav) => fav.productId == product.id);
    }
  }
}
