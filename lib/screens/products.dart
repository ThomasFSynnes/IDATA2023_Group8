import 'package:flutter/material.dart';
import 'package:user_manuals_app/widgets/grid_list.dart';
import 'package:easy_localization/easy_localization.dart';

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
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        appBar: AppBar(
          title: Text(
            'Oops..',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              'EmptyList'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            )),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              if (image.isNotEmpty) ...{
                Container(height: 70, width: 70, child: Image.asset(image)),
              } else ...{
                Container(height: 20, width: 20),
              },
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
