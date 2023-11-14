import 'package:user_manuals_app/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = Provider((ref) {
  return products;
});
