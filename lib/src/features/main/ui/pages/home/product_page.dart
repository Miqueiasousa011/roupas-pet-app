import 'package:flutter/material.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: const Column(
        children: [],
      ).applySpacing(spacing: 16).margin(const EdgeInsets.all(24)),
    );
  }
}
