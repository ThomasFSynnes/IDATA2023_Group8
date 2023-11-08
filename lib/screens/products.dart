import 'package:flutter/material.dart';
import 'package:user_manuals_app/widgets/grid_list.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen(
      {super.key,
      required this.products,
      required this.pageTitle,
      required this.image});

  final List products;
  final String pageTitle;
  final String image;

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
          Row(
            children: [
              Container(height: 70, width: 70, child: Image.asset(image)),
              Text(
                pageTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Expanded(
            child: GridList(list: products),
          ),
        ],
      ),
    );
  }
}
