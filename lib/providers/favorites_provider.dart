import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_manuals_app/data/userFavorites.dart';
import 'package:user_manuals_app/model/product.dart';

// A StateNotifier that manages the list of favorite products
class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super(userFavorits);

  // Method to toggle the favorite status of a product
  void toggleFavoriteStatus(Product item) {
    if (state.contains(item)) {
      state = state.where((e) => e.id != item.id).toList();
    } else {
      state = [...state, item];
    }
  }
}

// Provider for managing the favorites using FavoritesNotifier
final favorites =
    StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  return FavoritesNotifier();
});
