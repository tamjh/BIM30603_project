import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/ui/shared/size_fit.dart';

class HYHomeContent extends StatelessWidget {
  const HYHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const HeaderLabel(),
        const SearchBar(),
        const SizedBox(height: 10),
        const CategoriesSection(),
        const SizedBox(height: 10),
        ItemSection(
          title: "Hot",
          items: [
            {
              'title': 'Yonex',
              'price': 'RM200',
              'discountedPrice': 'RM148',
              'imagePath': 'assets/images/ph.png'
            },
            {
              'title': 'Adidas',
              'price': 'RM250',
              'discountedPrice': 'RM200',
              'imagePath': 'assets/images/ph.png'
            },
          ],
        ),
        const SizedBox(height: 30),
        ItemSection(
          title: "New",
          items: [
            {
              'title': 'Nike',
              'price': 'RM300',
              'discountedPrice': 'RM250',
              'imagePath': 'assets/images/ph.png'
            },
            {
              'title': 'Puma',
              'price': 'RM220',
              'discountedPrice': 'RM180',
              'imagePath': 'assets/images/ph.png'
            },
          ],
        ),
      ],
    );
  }
}

// Section 1: Header
class HeaderLabel extends StatelessWidget {
  const HeaderLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 20.px),
      child: Text(
        "Explore Sport Performance",
        style:
            Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 80.px),
      ),
    );
  }
}

// Section 2: Search Bar
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.px, vertical: 30.px),
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

// Section 3: Categories
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    const int numCategories = 4; // Number of categories
    final double spacing = 10.px; // Space between items

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.px),
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
    final double screenWidth = MediaQuery.sizeOf(context).width;
    double spacing = 10.px;
    final double availableWidth = screenWidth - (spacing * 5); // Adjust spacing
    final double radius =
        availableWidth / 4 / 2; // Dynamically calculate radius

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

// Section 4: Reusable Section Title
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 80.px),
          ),
          Row(
            children: [
              Text(
                "View All",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 30.px),
              ),
              Icon(Icons.arrow_right_sharp, size: 50.px),
            ],
          )
        ],
      ),
    );
  }
}

// Section 5: Reusable Item Section
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
          height: 1000.px,
          child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              final item = items[index];
              return SectionItem(
                index: index,
                title: item['title'] ?? '',
                price: item['price'] ?? '',
                discountedPrice: item['discountedPrice'] ?? '',
                imagePath: item['imagePath'] ?? '',
              );
            },
          ),
        ),
      ],
    );
  }
}

// Reusable Section Item
class SectionItem extends StatelessWidget {
  final int index;
  final String title;
  final String price;
  final String discountedPrice;
  final String imagePath;

  const SectionItem({
    required this.index,
    required this.title,
    required this.price,
    required this.discountedPrice,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double _favRadius = 100.px;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.px),
      width: 500.px,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2.px),
        borderRadius: BorderRadius.circular(12.px),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.px)),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 10.px,
              child: Container(
                width: _favRadius,
                height: _favRadius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.0),
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () {
                    // Your onPressed functionality here
                  },
                  icon: Icon(Icons.favorite_outline, color: Colors.red, size: _favRadius-20.px,),
                ),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.all(12.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 40.px,
                    fontFamily: GoogleFonts.tapestry().fontFamily,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Product $index",
                  style: TextStyle(
                    fontSize: 50.px,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.tapestry().fontFamily,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 40.px,
                        decoration: TextDecoration.lineThrough,
                        fontFamily: GoogleFonts.tapestry().fontFamily,
                      ),
                    ),
                    SizedBox(width: 30.px),
                    Text(
                      discountedPrice,
                      style: TextStyle(
                        fontSize: 52.px,
                        color: Colors.red,
                        fontFamily: GoogleFonts.tapestry().fontFamily,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
