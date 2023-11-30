import 'package:flutter/material.dart';
import 'package:user_manuals_app/data/products.dart';
import 'package:user_manuals_app/model/category.dart';
import 'package:user_manuals_app/model/manufacture.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/screens/product_screen.dart';
import 'package:user_manuals_app/screens/products.dart';
import 'package:user_manuals_app/util/database_manager.dart';

//**
// Flutter widget for display card
// it takes a dynamic item that can be product, manufacture or category then displays it
// has different logic depending on what the dynamic item is
// */

class DisplayCard extends StatelessWidget {
  const DisplayCard({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(8)),
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            child: InkWell(
              onTap: () {
                if (item is Product) {
                  // Navigate to the product page
                  _selectProduct(context, item);
                } else if (item is Manufacture) {
                  // Navigate to the manufacture page
                  _selectManufacturer(context, item);
                } else if (item is Category) {
                  // Navigate to the category page
                  _selectCategory(context, item);
                }
              },
              child: Stack(
                children: [
                  if (item is Product) ...{
                    //if product load product image from firestore, gives user feedback with a loading bar if image is still loading
                    Image.network(
                      item.imageUrl,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      fit: BoxFit.cover, // Fill the entire available space
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }
                      },
                    ),
                  } else ...{
                    //else if the item is manufacturer or category loads the local image for those
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(item.imageUrl),
                          fit: BoxFit
                              .fill, // Make the image cover all available space
                        ),
                      ),
                    ),
                  },
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 44),
                      child: Column(
                        children: [
                          Text(
                            item.title,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow
                                .ellipsis, //Cuts of very long text to end with ...
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//method for going to selected product screen
void _selectProduct(BuildContext context, Product product) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => ProductScreen(item: product),
    ),
  );
}

//method for going to selected manufacture screen
void _selectManufacturer(BuildContext context, Manufacture manufacturer) {
  List<Product> filteredProducts = products
      .where((product) => product.manufacture.id == manufacturer.id.toString())
      .toList();

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => ProductsScreen(
        products:
            filteredProducts, //gets filtered list of products for that manufacture
        pageTitle: manufacturer.title, //sets title to manufacture title
        image: manufacturer.imageUrl, //sets image to manufacture image
      ),
    ),
  );
}

//method for going to selected category screen
void _selectCategory(BuildContext context, Category category) async {
  // To store the ProductNotifier instance
  List<Product> filteredProducts =
      await DatabaseManager().getProductsByCategory(category.type);
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => ProductsScreen(
        products:
            filteredProducts, //gets filtered list of products for that category
        pageTitle: category.title, //sets title to categorytitle
        image: category.imageUrl, //sets image to category image
      ),
    ),
  );
}
