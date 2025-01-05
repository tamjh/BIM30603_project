import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/model/product_model.dart';
import 'package:project/core/viewmodel/fav_view_model.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';
import 'package:project/ui/widgets/item_display.dart';
import 'package:provider/provider.dart';

class FavContent extends StatefulWidget {
  const FavContent({super.key});

  @override
  _FavContentState createState() => _FavContentState();
}

class _FavContentState extends State<FavContent> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final favViewModel = Provider.of<FavViewModel>(context, listen: false);
      if (favViewModel.id.isNotEmpty) {
        favViewModel.fetchProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<FavViewModel, ProductViewModel>(
      builder: (context, favViewModel, productViewModel, child) {
        final String uid = favViewModel.id;

        // Use product IDs from favorites to fetch corresponding products
        final List<Product> favoriteProducts = favViewModel.favs
            .map((fav) {
          return productViewModel.products.firstWhere(
                (product) => product.id == fav.productId,
            orElse: () => Product(
              id: '', // Use a default/empty Product
              name: 'Unknown',
              image: '',
              price: 0,
              category: '',
              brand_id: '',
              description: [],
              created_at: DateTime.now(),
            ),
          );
        })
            .where((product) => product.id.isNotEmpty) // Filter out invalid products
            .toList();

        if (favViewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (favoriteProducts.isEmpty) {
          return Center(
            child: Text(
              "You have no favorite items.",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
          );
        }

        return GridView.builder(
          itemCount: favoriteProducts.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300.w,
            childAspectRatio: 0.5,
          ),
          itemBuilder: (BuildContext ctx, int index) {
            var product = favoriteProducts[index];
            return buildItem(product);
          },
        );
      },
    );
  }

  Widget buildItem(Product product) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: SectionItem(
              id: product.id,
              name: product.name,
              brand: product.brand_id,
              price: product.price,
              imagePath: product.image,
              ratio: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}
