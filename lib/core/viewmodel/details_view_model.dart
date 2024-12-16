import 'package:flutter/material.dart';
import 'package:project/core/services/product_service.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';

class HomeViewModel extends ChangeNotifier {
  final ProductService _service;
  final String id;

  List<ProductViewModel> detail = [];
  bool isLoading = false;

  HomeViewModel(this.id, this._service);

  Future<void> fetchProducts() async {
  isLoading = true;
  notifyListeners();

  try {
    // Fetch data from the service
    final detailData = await _service.getProductDetails(id);

    // Map the fetched data to ProductViewModel
    detail = [ProductViewModel(detailData)]; 
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

}
