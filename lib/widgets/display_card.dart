import 'package:flutter/material.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/screens/product_screen.dart';

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
      child: Card(
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
            }
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(item.imageUrl),
                    fit: BoxFit
                        .cover, // Make the image cover all available space
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
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
      ),
    );
  }
}

void _selectProduct(BuildContext context, Product product) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => ProductScreen(item: product),
    ),
  );
}
