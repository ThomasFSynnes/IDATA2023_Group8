import 'package:flutter/material.dart';
import 'package:user_manuals_app/model/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    super.key,
    required this.item,
  });

  final Product item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: Text(item.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: 300, // Set your desired height here
              child: ClipRect(
                child: Image.asset(
                  item.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: const Color(0xFFABD1C6),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              // TODO: IMPLEMENT FAVORITES
                            },
                            icon: Icon(
                              Icons.add,
                              color: Color(0xFF001E1D),
                            ),
                            label: Text(
                              'Add to selection',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // TODO: IMPLEMENT DOWNLOAD
                            },
                            icon: Icon(
                              Icons.download,
                              color: Color(0xFF001E1D),
                            ),
                            label: Text(
                              'Download User Manual',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
