import 'package:flutter/material.dart';
import 'package:project/ui/pages/product_detail/product_content.dart';
import 'package:project/ui/shared/size_fit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailScreen extends StatelessWidget {
  static final String routeName = "/details";
  const ProductDetailScreen ({super.key});

  @override
  Widget build(BuildContext context) {
        final String id =
        ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text("Product Name", style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 48.h))
          ),
        centerTitle: true,
        
      ),
      body: ProductDetailContent(id: id),
    );
  }
}