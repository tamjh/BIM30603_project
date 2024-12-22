import 'package:flutter/material.dart';
import 'package:project/core/model/product_model.dart';
import 'package:project/core/services/search_service.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchService _searchService = SearchService();

  List<String> _keywords = [];
  List<String> get keywords => _keywords;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  List<String> _selectedBrands = [];
  List<String> get selectedBrands => _selectedBrands;

  String _searchText = '';
  String get searchText => _searchText;

  void updateSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  void toggleBrandSelection(int index) {
    if (_keywords.isNotEmpty && index >= 0 && index < _keywords.length) {
      String brand = _keywords[index];
      if (_selectedBrands.contains(brand)) {
        _selectedBrands.remove(brand); // Unselect the brand if it's already selected
      } else {
        _selectedBrands.add(brand); // Select the brand
      }
      notifyListeners();
    }
  }

  void clearSearch(){
    _selectedBrands.clear();
    _keywords.clear();
    _searchText = "";
  }

  void addSelected(String item){
    if(item.isNotEmpty){
      _selectedBrands.add(item);
    }
    notifyListeners();
  }

  Future<void> fetchKeywords() async {
    try {
      _keywords = await _searchService.getAllKeywords();
      _selectedBrands.clear(); // Clear selected brands when keywords are fetched
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> searchItems(String searchTxt, List<String> selectedBrands, ProductViewModel productViewModel) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      List<Product> matchingProducts = await _searchService.searchItems(searchTxt, selectedBrands);
      productViewModel.updateProducts(matchingProducts);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }


}
