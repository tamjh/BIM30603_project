import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/shared/size_fit.dart';

class ShopContent extends StatefulWidget {
  const ShopContent({super.key});

  @override
  _ShopContentState createState() => _ShopContentState();
}

class _ShopContentState extends State<ShopContent> {
  String selectedFilter = "None";
  String selectedSort = "None";

  @override
  Widget build(BuildContext context) {
    final double _favRadius = 80.px;

    return Column(
      children: [
        buildFilterSection(context),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GridView.builder(
              itemCount: 100,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300.px,
                mainAxisSpacing: 12.px,
                crossAxisSpacing: 32.px,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (BuildContext ctx, int index) {
                return buildItem(_favRadius, context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFilterSection(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Filter Button
          Row(
            children: [
              Icon(Icons.filter_list),
              Text(
                "Filter: ",
                style: Theme.of(ctx).textTheme.displayLarge,
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
                  style: Theme.of(ctx).textTheme.displayMedium?.copyWith(color: Colors.blue),
                ),
                IconButton(
                  icon: Icon(Icons.sort),
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

  Widget _buildSortBottomSheet(BuildContext context, ScrollController scrollController) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(16.px),
        child: ListView(
          controller: scrollController,
          children: [
            Text(
              "Sort By",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Divider(),
            ListTile(
              title: Text("Price: Lowest to Highest"),
              onTap: () {
                setState(() {
                  selectedSort = "Price: Lowest to Highest";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Price: Highest to Lowest"),
              onTap: () {
                setState(() {
                  selectedSort = "Price: Highest to Lowest";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Popular"),
              onTap: () {
                setState(() {
                  selectedSort = "Popular";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Latest"),
              onTap: () {
                setState(() {
                  selectedSort = "Latest";
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Container buildItem(double _favRadius, BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImageStack(_favRadius),
          Text(
            "Yonex",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.grey),
          ),
          Text("Product E", style: Theme.of(context).textTheme.displayLarge),
          Text("RM 1314.00", style: Theme.of(context).textTheme.displayLarge),
        ],
      ),
    );
  }

  Stack buildImageStack(double _favRadius) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Image.asset("assets/images/ph.png"),
        Positioned(
          bottom: 0,
          right: 10.px,
          child: Container(
            width: _favRadius,
            height: _favRadius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1.0.px),
              color: Colors.white,
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  // Your onPressed functionality here
                },
                icon: Icon(
                  Icons.favorite_outline,
                  color: Colors.red,
                  size: _favRadius - 20.0.px,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
