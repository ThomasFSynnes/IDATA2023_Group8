import 'package:flutter/material.dart';
import 'package:user_manuals_app/widgets/grid_list.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.products});

  final List products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      // Handle the case when the products list is empty.
      return Scaffold(
        appBar: AppBar(
          title: const Text('Oops..'),
        ),
        body: const Center(
          child: Text('No products available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Screen'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            "TEXT HERE SHOULD BE CATEGORY OR MANUFACTURER",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GridList(list: products),
          ),
        ],
      ),
    );
  }
}
