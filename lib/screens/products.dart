import 'package:flutter/material.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/widgets/grid_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:user_manuals_app/widgets/product_seach_deligate.dart';

//**
// Flutter page for a displaying products
//
// BUT is also used for listing Manufacturer and Category
// */

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
      // Handle the case when the products list is empty and shows a message
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

    //Else displays products

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        actions: [
          // can search if list has items and items is Product
          if (products.isNotEmpty && products.first is Product)
            IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: ProductSeachDeligate(searchList: products));
                },
                icon: const Icon(Icons.search)),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              //LOGIC USED ONLY FOR MANUFACTURER/CATEGORIES
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
