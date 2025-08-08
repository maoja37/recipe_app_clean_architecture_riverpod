import 'package:flutter/material.dart';
import 'package:recipe_huto_test/core/constants/size.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          VerticalSpacing(16),
          Text('Searching recipes...'),
        ],
      ),
    );
  }
}