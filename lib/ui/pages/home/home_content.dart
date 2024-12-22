import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/viewmodel/home_view_modal.dart';
import 'package:project/core/viewmodel/index_view_model.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';
import 'package:project/core/viewmodel/search_view_model.dart';
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
    final productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: [
            const HeaderLabel(),
            SearchBar(productViewModel: productViewModel),
            SizedBox(height: 10.h),
            CategoriesSection(productViewModel: productViewModel),
            SizedBox(height: 10.h),
            ItemSection(
              title: "Hot",
              items: viewModel.hotProducts.map((product) {
                return {
                  'id': product.id,
                  'name': product.name,
                  'price': product.price,
                  'brand': product.brand,
                  'imagePath': product.image,
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
                  'imagePath': product.image,
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
  final TextEditingController searchController = TextEditingController();
  final ProductViewModel productViewModel;

  SearchBar({required this.productViewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
        builder: (context, searchviewmodel, child) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Searching...",
                label: const Text("Search"),
                suffixIcon: IconButton(
                    onPressed: () {
                      searchviewmodel.updateSearchText(searchController.text);
                      searchviewmodel.searchItems(
                          searchviewmodel.searchText.toLowerCase().trim(),
                          searchviewmodel.selectedBrands,
                          productViewModel);
                      context.read<NavigationViewModel>().setCurrentIndex(2);
                    },
                    icon: const Icon(Icons.search)),
              ),
            ),
          );
        });
  }
}

class CategoriesSection extends StatelessWidget {
  final List<String> categories = ['badminton', 'football', 'basketball', 'accessories'];
  final ProductViewModel productViewModel;

  CategoriesSection({required this.productViewModel, super.key});

  @override
  Widget build(BuildContext context) {
    int numCategories = categories.length;
    final double spacing = 10.w;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: spacing,
        runSpacing: spacing,
        children: List.generate(
          numCategories,
              (index) => CategoryItem(
            productViewModel: productViewModel,
            keyword: categories[index],
          ),
        ),
      ),
    );
  }
}


class CategoryItem extends StatelessWidget {
  final String keyword;
  final ProductViewModel productViewModel;

  CategoryItem({required this.productViewModel, required this.keyword, super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double spacing = 10.w;
    final double availableWidth = screenWidth - (spacing * 5);
    final double radius = availableWidth / 4 / 3;

    return Consumer<SearchViewModel>(
        builder: (context, searchViewModel, child) {
          return GestureDetector(
            onTap: () {
              searchViewModel.clearSearch();
              searchViewModel.addSelected(keyword);
              searchViewModel.searchItems(
                  searchViewModel.searchText.toLowerCase().trim(),
                  searchViewModel.selectedBrands,
                  productViewModel);
              context.read<NavigationViewModel>().setCurrentIndex(2);
            },
            child: Container(
              width: radius * 2,
              height: radius * 2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Image.asset(
                  'assets/images/pro/$keyword.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: radius,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
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
              context.read<NavigationViewModel>().setCurrentIndex(2);
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
                  width: MediaQuery.of(context).size.width *
                      0.5, // Fixed width for each item

                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.5, // Adjust width as needed
                    child: SectionItem(
                      id: item['id'] ?? '',
                      name: item['name'] ?? '',
                      brand: item['brand'] ?? '',
                      price: item['price'] ?? '',
                      imagePath: item['imagePath'] ?? '',
                      ratio: 0.6,
                    ),
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
