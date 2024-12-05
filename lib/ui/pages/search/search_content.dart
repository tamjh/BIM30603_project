import 'package:flutter/material.dart';
import 'package:project/ui/shared/size_fit.dart';

class SearchContent extends StatefulWidget {
  SearchContent({super.key});

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 249, 249, 249),
      child: Column(
        children: [
          buildSearch(),
          buildSelection(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.px),
            child: buildButtons(),
          ),
        ],
      ),
    );
  }

  Padding buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: searchcontroller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Searching"),
          hintText: "Insert Product Name",
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Row buildButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 100.px,
            margin: EdgeInsets.symmetric(horizontal: 5.0), // Adds spacing
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 249, 249, 249),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
              onPressed: () {
                print("Discard Searching....");
                setState(() {
                  searchcontroller.text = "";
                });
              },
              child: Text("Discard"),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 100.px,
            margin: EdgeInsets.symmetric(horizontal: 5.0), // Adds spacing
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {
                print("${searchcontroller.text}");
              },
              child: Text(
                "Search",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class buildSelection extends StatefulWidget {
  const buildSelection({super.key});

  @override
  _BuildSelectionState createState() => _BuildSelectionState();
}

class _BuildSelectionState extends State<buildSelection> {
  // State to track the selected items
  final List<bool> _selectedBrands = List<bool>.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: List.generate(10, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  // Toggle the selection state of the brand
                  _selectedBrands[index] = !_selectedBrands[index];
                });
                print("Brand ${index + 1} selected: ${_selectedBrands[index]}");
              },
              child: ListTile(
                title: Text(
                  "Brand ${index + 1}",
                  style: TextStyle(
                      color:
                          _selectedBrands[index] ? Colors.red : Colors.black),
                ),
                trailing: Icon(
                  _selectedBrands[index]
                      ? Icons.check_box // Selected icon
                      : Icons.check_box_outline_blank,
                  color: Colors.red,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
