// home_view_model.dart
import 'package:flutter/material.dart';
import 'package:project/core/services/home_service.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeService _service;

  List<ProductViewModel> hotProducts = [];
  List<ProductViewModel> newProducts = [];
  bool isLoading = false;

  HomeViewModel(this._service);

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      final hotProductsData = await _service.getHotProducts();
      final newProductsData = await _service.getNewProducts();

      hotProducts = hotProductsData.map((p) => ProductViewModel(p)).toList();
      newProducts = newProductsData.map((p) => ProductViewModel(p)).toList();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
