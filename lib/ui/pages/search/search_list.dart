import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/viewmodel/search_view_model.dart';
import 'package:provider/provider.dart';


class BuildSelection extends StatelessWidget {
  const BuildSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, searchViewModel, child) {
        final keywords = searchViewModel.keywords;
        final selectedBrands = searchViewModel.selectedBrands;

        if (keywords.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Expanded(
          child: ListView.builder(
            itemCount: keywords.length,
            itemBuilder: (context, index) {
              final brand = keywords[index];
              final isSelected = selectedBrands.contains(brand);

              return GestureDetector(
                onTap: () {
                  searchViewModel.toggleBrandSelection(index);
                },
                child: ListTile(
                  title: Text(
                    brand,
                    style: TextStyle(
                      color: isSelected ? Colors.red : Colors.black, // Apply color based on selection
                      fontSize: 20.sp,
                      fontFamily: GoogleFonts.tapestry().fontFamily,
                    ),
                  ),
                  trailing: Icon(
                    isSelected ? Icons.check_box : Icons.check_box_outline_blank, // Check if selected
                    color: Colors.red,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
