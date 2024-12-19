import 'package:flutter/material.dart';
import 'package:project/core/model/fav_model.dart';
import 'package:project/core/services/product_service.dart';


class FavViewModel extends ChangeNotifier {
  final ProductService _service;

  //user id
  final String id;
  List<Favourite> favs = [];
  bool isLoading = false;

  FavViewModel(this.id, this._service);

  bool isFavorite(String id) {
    return favs.any((fav) => fav.productId == id);
  }



  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch data from the service
      final favData = await _service.getFavItems(id);

      // Map the fetched data to ProductViewModel
      favs = favData;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFav(String productId) async {
    try {
      isLoading = true;
      notifyListeners();

      // Create a Favourite object
      final favourite = Favourite(
        productId: productId,
        createdAt: DateTime.now(),
      );

      // Call the service to add the favourite item
      await _service.addFavItem(id, favourite);
      print('success');
      // Optionally, update the local list of favourites
      fetchProducts(); // Re-fetch favourites to update the list
    } catch (e) {
      print("Error adding favourite: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Remove a product from favorites
  Future<void> removeFav(String productId) async {
  try {
    isLoading = true;
    notifyListeners();

    // Call the service to remove the favourite item
    await _service.removeFavItem(id, productId);
    print("Favorite removed successfully!");

    // Update the local list of favourites
    favs.removeWhere((fav) => fav.productId == productId);

    // Optionally, fetch updated list to sync with server
    await fetchProducts(); // This ensures the local list is up to date
  } catch (e) {
    print("Error removing favourite: $e");
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

}
