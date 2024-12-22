import 'package:flutter/material.dart';
import 'package:project/core/viewmodel/search_view_model.dart';
import 'package:provider/provider.dart';

class buildSearch extends StatelessWidget {
  const buildSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child:
          Consumer<SearchViewModel>(builder: (context, searchviewmodel, child) {
        return TextField(
            onChanged: (text) {
              searchviewmodel.updateSearchText(text);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Searching"),
              hintText: "Insert Product Name",
              suffixIcon: Icon(Icons.search),
            ));
      }),
    );
  }
}
