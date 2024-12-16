// product_view_model.dart

import 'package:project/core/model/product_model.dart';

class ProductViewModel {
  final Product _product;

  ProductViewModel(this._product);

  String get id => _product.id;
  String get name => _product.name;
  String get image => _product.image;
  num get price => _product.price;
  String get category => _product.category;
  String get brand => _product.brand_id;
  List<String> get description => _product.description.map((d) => '${d.key}: ${d.value}').toList();
}