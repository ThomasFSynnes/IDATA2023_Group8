import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_manuals_app/data/products.dart';

final productProvider = Provider((ref) {
  return products;
});

