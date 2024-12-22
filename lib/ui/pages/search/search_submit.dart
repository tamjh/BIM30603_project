import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/viewmodel/product_view_modal.dart';
import 'package:project/core/viewmodel/search_view_model.dart';
import 'package:provider/provider.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, searchViewModel, child) {
        final productViewModel =
            Provider.of<ProductViewModel>(context, listen: false);

        return Row(
          children: [
            // Discard button
            Expanded(
              child: Container(
                height: 60.h,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 249, 249, 249),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.black, width: 2.w),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Reset the search text and selections
                    searchViewModel.updateSearchText('');
                    searchViewModel.fetchKeywords();
                  },
                  child: Text(
                    "Discard",
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
              ),
            ),
            // Search button
            Expanded(
              child: Container(
                height: 60.h,
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    print("Search text: ${searchViewModel.searchText}");

                    // Get the selected brands based on the String list
                    final selectedBrands = searchViewModel.selectedBrands;

                    // Perform search with selected brands and search text
                    searchViewModel.searchItems(
                        searchViewModel.searchText.toLowerCase().trim(),
                        selectedBrands,
                        productViewModel);

                    Navigator.pop(context); // Close the search modal
                  },
                  child: Text(
                    "Search",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
