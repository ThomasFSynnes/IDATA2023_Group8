import 'package:user_manuals_app/data/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider definition to expose the products data

final productProvider = Provider((ref) {
  return products;
});
