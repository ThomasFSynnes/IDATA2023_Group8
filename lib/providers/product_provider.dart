import 'package:user_manuals_app/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/util/database_manager.dart';

final productProvider = Provider((ref) {
  return products;
});