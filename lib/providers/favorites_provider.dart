import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_manuals_app/data/userFavorites.dart';
import 'package:user_manuals_app/model/product.dart';

//Used
class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super(userFavorits);

  void toggleFavoriteStatus(Product item) {
    if (state.contains(item)) {
      state = state.where((e) => e.id != item.id).toList();
    } else {
      state = [...state, item];
    }
  }
}

final favorites =
    StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  return FavoritesNotifier();
});
