
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_manuals_app/data/userFavorites.dart';
import 'package:user_manuals_app/model/product.dart';

class FavoritesNotifier extends StateNotifier<List<Product>>{
  FavoritesNotifier() : super(favorits);

  void toggleFavoriteStatus(Product item){
    if (state.contains(item)){
      state = state.where((e) => e.id != item.id).toList();
    } 
    else {
      state = [...state, item];
    }
    
    state = [];
  }

}

final favorites = StateNotifierProvider<FavoritesNotifier,List<Product>> ((ref) {
  return FavoritesNotifier();
});