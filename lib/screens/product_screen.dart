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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.background,
        ),
        title: Text(item.title, style: Theme.of(context).textTheme.titleLarge),
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
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Model Number: ' +
                          (item.modelNumber?.toString() ?? 'N/A'),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      'Release year: ' +
                          (item.releaseYear?.toString() ?? 'N/A'),
                      style: Theme.of(context).textTheme.titleSmall,
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
                            icon: const Icon(
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
                            icon: const Icon(
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
