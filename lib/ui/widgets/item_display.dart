import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/viewmodel/fav_view_model.dart';
import 'package:project/ui/pages/product_detail/product_detail.dart';
import 'package:provider/provider.dart';

class SectionItem extends StatelessWidget {
  final String name;
  final String brand;
  final num price;
  final String imagePath;
  final String id;
  final double ratio;

  const SectionItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imagePath,
    super.key,
    this.ratio = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double maxItemWidth = screenWidth * ratio;
    final double itemWidth =
        screenWidth < 1200 ? maxItemWidth : screenWidth * ratio;
    final double favIconSize = 24.sp;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        width: itemWidth,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.5.w),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Stack(
          children: [
            Column(
              
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.w)),
                  child: Image.asset(
                    "assets/images/pro/$imagePath.png",
                    width: itemWidth,
                    height: itemWidth * 0.7,
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
                        "RM ${price.toStringAsFixed(2)}",
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
            Consumer<FavViewModel>(
              builder: (context, viewmodel, child) {
                bool isFavorite = viewmodel.isFavorite(id);

                return Positioned(
                  bottom: 10.h,
                  right: 1.w,
                  child: IconButton(
                    onPressed: () {
                      if (isFavorite) {
                        viewmodel.removeFav(id);
                      } else {
                        viewmodel.addFav(id);
                      }
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: favIconSize,
                    ),
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
