import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_manuals_app/data/userFavorites.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/util/database_manager.dart';

class FavoritesButton extends StatefulWidget {
  const FavoritesButton({
    super.key,
    required this.item,
  });

  final Product item;

  @override
  State<StatefulWidget> createState() => _FavoritesButton();
}

class _FavoritesButton extends State<FavoritesButton> {
  DatabaseManager db = DatabaseManager();

  @override
  Widget build(BuildContext context) {
    bool isFavorite = favorits.contains(widget.item);

    addFavorites() async {
      await db.addFavorites(widget.item);
      setState(() {
        isFavorite = true;
      });
    }

    removeFavorites() async {
      await db.removeFavorites(widget.item);
      setState(() {
        isFavorite = false;
      });
    }

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (isFavorite) {
            return IconButton(
                onPressed: removeFavorites, icon: const Icon(Icons.star));
          } else {
            return IconButton(
                onPressed: addFavorites, icon: const Icon(Icons.star_border));
          }
        }
        return Container();
      },
    );
  }
}
