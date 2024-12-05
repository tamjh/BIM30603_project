import 'package:flutter/material.dart';
import 'package:project/ui/pages/main/initialized.dart';

class HYMainScreen extends StatefulWidget {
  static final String routeName = "/";
  const HYMainScreen({super.key});

  @override
  State<HYMainScreen> createState() => _HYMainScreenState();
}

class _HYMainScreenState extends State<HYMainScreen> {
  int _cur = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _cur,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _cur,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          setState(() {
            _cur = value;
          });
        },
      ),
    );
  }
}
