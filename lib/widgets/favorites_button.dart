import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/providers/favorites_provider.dart';
import 'package:user_manuals_app/util/database_manager.dart';

//TODO: ADD MORE COMMENTS

class FavoritesButton extends ConsumerStatefulWidget {
  const FavoritesButton({
    super.key,
    required this.item,
  });

  final Product item;

  @override
  ConsumerState<FavoritesButton> createState() => _FavoritesButton();
}

class _FavoritesButton extends ConsumerState<FavoritesButton> {
  DatabaseManager db = DatabaseManager();

  @override
  Widget build(BuildContext context) {
    bool isFavorite = ref.read(favorites).contains(widget.item);

    addFavorites() async {
      await db.addFavorites(widget.item);
      ref.read(favorites.notifier).toggleFavoriteStatus(widget.item);
      setState(() {
        isFavorite = true;
      });
    }

    removeFavorites() async {
      await db.removeFavorites(widget.item);
      ref.read(favorites.notifier).toggleFavoriteStatus(widget.item);
      setState(() {
        isFavorite = false;
      });
    }

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        if (isFavorite) {
          return IconButton(
              onPressed: removeFavorites, icon: const Icon(Icons.star));
        }
        return IconButton(
            onPressed: addFavorites, icon: const Icon(Icons.star_border));
      },
    );
  }
}
