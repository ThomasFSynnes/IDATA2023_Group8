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
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 40,
          ),
          Row(children: [
            Expanded(
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ]),
          const SizedBox(
            height: 40,
          ),
          Text(
            item.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(children: [
            TextButton.icon(
              onPressed: () {
                // TODO: IMPLEMENT FAVOURITES
              },
              icon: Icon(Icons.add),
              label: Text('Add to selection',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            TextButton.icon(
              onPressed: () {
                // TODO: IMPLEMENT DOWNLOAD
              },
              icon: Icon(Icons.download),
              label: Text('Download User Manual',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ]),
        ]),
      ),
    );
  }
}
