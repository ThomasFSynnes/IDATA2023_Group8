import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_manuals_app/data/products.dart';
import 'package:user_manuals_app/data/userFavorites.dart';
import 'package:user_manuals_app/model/category.dart';
import 'package:user_manuals_app/model/manufacture.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/providers/favorites_provider.dart';

/// A class that handels the database.
///
class DatabaseManager {
  final database = FirebaseFirestore.instance;
  final keyUserFavorites = "usersFavorites";
  final keyProducts = "products";

  // Adds a product to database
  addProduct(Product product) {
    database.collection(keyProducts).doc().set(product.toFirestore());
  }

  // Update a product in the database
  updateProduct(Product product){
    database.collection(keyProducts).doc(product.id).update(product.toFirestore());
  }

  //Create an empty list in the DB
  createFavorites() {
    if (FirebaseAuth.instance.currentUser == null) return;
    User user = FirebaseAuth.instance.currentUser!;
    Map<String, dynamic> addThis = {
      "favoritesIdList": FieldValue.arrayUnion([])
    };
    database.collection(keyUserFavorites).doc(user.uid).set(addThis);
  }

  //Add an item to  favorites
  addFavorites(Product product) {
    if (FirebaseAuth.instance.currentUser == null) return;
    //userFavorits.add(product);
    favorites;

    User user = FirebaseAuth.instance.currentUser!;
    Map<String, dynamic> addThis = {
      "favoritesIdList": FieldValue.arrayUnion([product.id])
    };
    database.collection(keyUserFavorites).doc(user.uid).update(addThis);
  }

  //Remove an item from favorites
  removeFavorites(Product product) {
    if (FirebaseAuth.instance.currentUser == null) return;

    User user = FirebaseAuth.instance.currentUser!;
    Map<String, dynamic> addThis = {
      "favoritesIdList": FieldValue.arrayRemove([product.id])
    };
    database.collection(keyUserFavorites).doc(user.uid).update(addThis);
  }

  //get all favorites from for a given user.
  Future<List<Product>> syncFavorites() async {
    if (FirebaseAuth.instance.currentUser == null) return [];
    User user = FirebaseAuth.instance.currentUser!;

    await database
        .collection(keyUserFavorites)
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      List test = List.from(data["favoritesIdList"]);
      userFavorits = products
          .where((Product product) => test.contains(product.id))
          .toList();
    });

    return userFavorits;
  }

  //Converts a database Querry to a List of Products.
  List<Product> _fromQuerySnapshotToProducts(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    List<Product> products = [];

    for (var docSnapshot in querySnapshot.docs) {
      Product product = Product.fromFirestore(docSnapshot);
      products.add(product);
    }

    return products;
  }

  //get all products from a given category.
  Future<List<Product>> getProductsByCategory(Categories category) async {
    return await database
        .collection(keyProducts)
        .where("category", isEqualTo: category.name)
        .get()
        .then((querySnapshot) => _fromQuerySnapshotToProducts(querySnapshot));
  }

  //Async. get all products from a given manufacture.
  Future<List<Product>> getProductsByManufacture(
      Manufacturers manufacture) async {
    return await database
        .collection(keyProducts)
        .where("manufacture", isEqualTo: manufacture.name)
        .get()
        .then((querySnapshot) => _fromQuerySnapshotToProducts(querySnapshot));
  }

  // Gets all products from the database and creates Products objects and add them to dummydata list.
  getAllProducts() async {
    await database
        .collection(keyProducts)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Product product = Product.fromFirestore(docSnapshot);
        products.add(product);
      }
    });
  }
}
