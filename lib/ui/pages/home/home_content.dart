import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/viewmodel/home_view_modal.dart';
import 'package:project/core/viewmodel/index_view_model.dart';
import 'package:project/ui/widgets/item_display.dart';
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
                  'price': product.price,
                  'brand': product.brand,
                  'imagePath': product.image ?? 'assets/images/ph.png',
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
                  'price': product.price,
                  'brand': product.brand,
                  'imagePath': product.image ?? 'assets/images/ph.png',
                };
              }).toList(),
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
  final List<Map<String, dynamic>> items;

  const ItemSection({required this.title, required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        SizedBox(
          height: 400.h,
          child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {},
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5, // Fixed width for each item
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5, // Adjust width as needed
                        child: SectionItem(
                          id: item['id'] ?? '',
                          name: item['name'] ?? '',
                          brand: item['brand'] ?? '',
                          price: item['price'] ?? '',
                          imagePath: item['imagePath'] ?? '',
                          ratio: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
