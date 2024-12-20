import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/model/product_model.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';
import 'package:project/ui/pages/product_detail/product_detail.dart';
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
                  return Center(child: CircularProgressIndicator());
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
                "Filter: ",
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100.sp),
              topRight: Radius.circular(100.sp)),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.sp),
        child: ListView(
          controller: scrollController,
          children: [
            // Price: Lowest to Highest
            Container(
              decoration: BoxDecoration(
                color: selectedSort == "Price: Lowest to Highest"
                    ? Colors.red[100]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                    10.sp), // Rounded corners for the ListTile
              ),
              child: ListTile(
                title: Text(
                  "Price: Lowest to Highest",
                  style: TextStyle(
                    color: selectedSort == "Price: Lowest to Highest"
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedSort = "Price: Lowest to Highest";
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            // Price: Highest to Lowest
            Container(
              decoration: BoxDecoration(
                color: selectedSort == "Price: Highest to Lowest"
                    ? Colors.red[100]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                    10.sp), // Rounded corners for the ListTile
              ),
              child: ListTile(
                title: Text(
                  "Price: Highest to Lowest",
                  style: TextStyle(
                    color: selectedSort == "Price: Highest to Lowest"
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedSort = "Price: Highest to Lowest";
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            // Popular
            Container(
              decoration: BoxDecoration(
                color: selectedSort == "Popular"
                    ? Colors.red[100]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                    10.sp), // Rounded corners for the ListTile
              ),
              child: ListTile(
                title: Text(
                  "Popular",
                  style: TextStyle(
                    color:
                        selectedSort == "Popular" ? Colors.red : Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedSort = "Popular";
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            // Latest
            Container(
              decoration: BoxDecoration(
                color: selectedSort == "Latest"
                    ? Colors.red[100]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                    10.sp), // Rounded corners for the ListTile
              ),
              child: ListTile(
                title: Text(
                  "Latest",
                  style: TextStyle(
                    color: selectedSort == "Latest" ? Colors.red : Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedSort = "Latest";
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(Product product) {
    return GestureDetector(
      onTap: () {
        
      },
      
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
