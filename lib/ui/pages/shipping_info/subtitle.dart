import 'package:flutter/material.dart';
import 'package:project/ui/shared/size_fit.dart';

class BuildSubTitle extends StatelessWidget {
  final String title;
  const BuildSubTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 50.px,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}