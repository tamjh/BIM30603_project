import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/viewmodel/search_view_model.dart';
import 'package:project/ui/pages/search/search_bar.dart';
import 'package:project/ui/pages/search/search_list.dart';
import 'package:project/ui/pages/search/search_submit.dart';
import 'package:provider/provider.dart';

class SearchContent extends StatelessWidget {
  const SearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
        builder: (context, searchViewModel, child) {

      if (searchViewModel.keywords.isEmpty) {
        searchViewModel.fetchKeywords();
      }
      return Container(
        color: const Color.fromARGB(255, 249, 249, 249),
        child: Column(
          children: [
            buildSearch(),
            BuildSelection(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: BuildButton(),
            ),
          ],
        ),
      );
    });
  }
}
