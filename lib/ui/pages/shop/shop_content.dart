import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/model/product_model.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';
import 'package:project/ui/widgets/item_display.dart';
import 'package:provider/provider.dart';

class ShopContent extends StatefulWidget {
  const ShopContent({super.key});

  @override
  _ShopContentState createState() => _ShopContentState();
}

class _ShopContentState extends State<ShopContent> {
  String selectedFilter = "None";
  String selectedSort = "None";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final productViewModel =
          Provider.of<ProductViewModel>(context, listen: false);
      productViewModel.fetchAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildFilterSection(context),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Consumer<ProductViewModel>(
              builder: (context, productViewModel, child) {
                var products = productViewModel.products;

                if (products.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300.w,
                    childAspectRatio: 0.5,
                  ),
                  itemBuilder: (BuildContext ctx, int index) {
                    var product = products[index];
                    return buildItem(product);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /**
   * ---------------------------------------------------------------------------------
   * 
   *      Filter Bar
   * 
   * --------------------------------------------------------------------------------
   */
  Widget buildFilterSection(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Filter Button
          Row(
            children: [
              const Icon(Icons.filter_list),
              Text(
                "Sort: ",
                style: Theme.of(ctx).textTheme.displayLarge?.copyWith(
                      fontSize: 24.sp,
                    ),
              ),
            ],
          ),
          // Sort Button
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedSort,
                  style: Theme.of(ctx).textTheme.displayMedium?.copyWith(
                        color: Colors.blue,
                        fontSize: 18.sp,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: () {
                    // Show Bottom Sheet for Sorting
                    showFlexibleBottomSheet<void>(
                      minHeight: 0.1,
                      initHeight: 0.3,
                      maxHeight: 0.5,
                      context: ctx,
                      builder: (context, scrollController, offset) {
                        return _buildSortBottomSheet(context, scrollController);
                      },
                      anchors: [0.1, 0.3, 0.5],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortBottomSheet(
      BuildContext context, ScrollController scrollController) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 8.sp),
        child: ListView(
          controller: scrollController,
          children: [
            _buildSortOption(context, "Price: Lowest to Highest"),
            _buildSortOption(context, "Price: Highest to Lowest"),
            _buildSortOption(context, "Latest"),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(BuildContext context, String criteria) {
    return Container(
      decoration: BoxDecoration(
        color: selectedSort == criteria ? Colors.red[100] : Colors.transparent,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: ListTile(
        title: Text(
          criteria,
          style: TextStyle(
            color: selectedSort == criteria ? Colors.red : Colors.black,
          ),
        ),
        onTap: () {
          setState(() {
            selectedSort = criteria;
          });

          // Trigger sorting in the ViewModel
          Provider.of<ProductViewModel>(context, listen: false)
              .sortProducts(criteria);

          Navigator.pop(context);
        },
      ),
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
