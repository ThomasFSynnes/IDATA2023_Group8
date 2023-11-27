import 'package:flutter/material.dart';
import 'package:user_manuals_app/data/products.dart';
import 'package:user_manuals_app/model/category.dart';
import 'package:user_manuals_app/model/manufacture.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/screens/product_screen.dart';
import 'package:user_manuals_app/screens/products.dart';
import 'package:user_manuals_app/util/database_manager.dart';

class VerticalList extends StatelessWidget {
  final List items;

  const VerticalList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Container(
          width: double.infinity,
          height: 170,
          child: Card(
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            color: Colors.lightBlue[50],
            child: InkWell(
              onTap: () {
                _handleTap(context, item);
              },
              child: Row(
                children: [
                  Container(
                    width: 200,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(item.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        item.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _handleTap(BuildContext context, dynamic item) {
    if (item is Product) {
      _selectProduct(context, item);
    } else if (item is Manufacture) {
      _selectManufacturer(context, item);
    } else if (item is Category) {
      _selectCategory(context, item);
    }
  }

  void _selectProduct(BuildContext context, Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ProductScreen(item: product),
      ),
    );
  }

  void _selectManufacturer(BuildContext context, Manufacture manufacturer) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DisplayManufacturer(manufacturer: manufacturer),
      ),
    );
  }

  void _selectCategory(BuildContext context, Category category) async {
    List<Product> filteredProducts =
        await DatabaseManager().getProductsByCategory(category.type);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ProductsScreen(
          products: filteredProducts,
          pageTitle: category.title,
          image: category.imageUrl,
        ),
      ),
    );
  }
}

class DisplayManufacturer extends StatelessWidget {
  const DisplayManufacturer({
    super.key,
    required this.manufacturer,
  });

  final Manufacture manufacturer;

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = products
        .where((product) => product.manufacture.id == manufacturer.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(manufacturer.title),
      ),
      body: ProductsScreen(
        products: filteredProducts,
        pageTitle: manufacturer.title,
        image: manufacturer.imageUrl,
      ),
    );
  }
}
