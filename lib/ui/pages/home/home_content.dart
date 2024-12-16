import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/viewmodel/home_view_modal.dart';
import 'package:project/core/viewmodel/index_view_model.dart';
import 'package:project/ui/pages/product_detail/product_detail.dart';
import 'package:provider/provider.dart';

class HYHomeContent extends StatefulWidget {
  const HYHomeContent({super.key});

  @override
  _HYHomeContentState createState() => _HYHomeContentState();
}

class _HYHomeContentState extends State<HYHomeContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
      await homeViewModel.fetchProducts();
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: [
            const HeaderLabel(),
            const SearchBar(),
            SizedBox(height: 10.h),
            const CategoriesSection(),
            SizedBox(height: 10.h),
            ItemSection(
              title: "Hot",
              items: viewModel.hotProducts.map((product) {
                return {
                  'id': product.id,
                  'name': product.name,
                  'price': product.price.toString(),
                  'brand': product.brand,
                  'imagePath': product.image ?? 'assets/images/placeholder.png',
                };
              }).toList(),
            ),
            SizedBox(height: 30.h),
            ItemSection(
              title: "New",
              items: viewModel.newProducts.map((product) {
                return {
                  'id': product.id,
                  'name': product.name,
                  'price': product.price.toString(),
                  'brand': product.brand,
                  'imagePath': product.image ?? 'assets/images/placeholder.png',
                };
              }).toList(),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to ShopScreen
                Provider.of<NavigationViewModel>(context, listen: false)
                    .setCurrentIndex(1);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: Text(
                  "Go to Shop",
                  style: TextStyle(fontSize: 20.sp, color: Colors.blue),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class HeaderLabel extends StatelessWidget {
  const HeaderLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Text(
        "Explore Sport Performance",
        style:
            Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40.sp),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: "Searching...",
          label: const Text("Search"),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    const int numCategories = 4;
    final double spacing = 10.w;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: List.generate(numCategories, (index) => const CategoryItem()),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double spacing = 10.w;
    final double availableWidth = screenWidth - (spacing * 5);
    final double radius = availableWidth / 4 / 2;

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
    );
  }
}

class SectionTitle extends StatefulWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  State<SectionTitle> createState() => _SectionTitleState();
}

class _SectionTitleState extends State<SectionTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 40.sp),
          ),
          GestureDetector(
            onTap: () {
              context.read<NavigationViewModel>().setCurrentIndex(3);
            },
            child: Row(
              children: [
                Text(
                  "View All",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 20.sp),
                ),
                Icon(Icons.arrow_right_sharp, size: 20.sp),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ItemSection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;

  const ItemSection({required this.title, required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.75,
          child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {},
                child: SectionItem(
                  index: index,
                  id: item['id'] ?? '',
                  name: item['name'] ?? '',
                  brand: item['brand'] ?? '',
                  price: item['price'] ?? '',
                  imagePath: item['imagePath'] ?? '',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SectionItem extends StatelessWidget {
  final int index;
  final String name;
  final String brand;
  final String price;
  final String imagePath;
  final String id;

  const SectionItem({
    required this.index,
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double maxItemWidth = screenWidth * 0.3;
    final double itemWidth =
        screenWidth < 1200 ? maxItemWidth : screenWidth * 0.3;
    final double itemHeight = itemWidth * 1.6;
    final double favIconSize = 24.sp;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        width: itemWidth,
        height: itemHeight,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.5.w),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.w)),
                  child: Image.asset(
                    "assets/images/pro/$imagePath.png",
                    width: itemWidth,
                    height: itemHeight * 0.6,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brand,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontFamily: GoogleFonts.tapestry().fontFamily,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.tapestry().fontFamily,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "RM $price",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontFamily: GoogleFonts.tapestry().fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10.h,
              right: 1.w,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_outline,
                  color: Colors.red,
                  size: favIconSize,
                ),
                style: const ButtonStyle(
                  splashFactory:
                      NoSplash.splashFactory, // Disable splash effect
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
