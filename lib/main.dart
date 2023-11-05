import 'package:flutter/material.dart';
import 'package:user_manuals_app/data/dummy_data.dart';
import 'package:user_manuals_app/providers/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_manuals_app/widgets/horizontal_list.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final products = ref.read(productProvider);
      return MaterialApp(
        home: Scaffold(
            body: Column(children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Products",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          HorizontalList(list: products.toList()),
          const Text(
            "Brands",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const HorizontalList(list: availableManufactures),
          const Text(
            "Categories",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const HorizontalList(list: availableCategories)
        ])),
      );
    });
  }
}
