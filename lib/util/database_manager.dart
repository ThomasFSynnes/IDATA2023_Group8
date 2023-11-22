import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_manuals_app/data/products.dart';
import 'package:user_manuals_app/model/category.dart';
import 'package:user_manuals_app/model/manufacture.dart';
import 'package:user_manuals_app/model/product.dart';

/// A class that handels the database.
///
class DatabaseManager {
  final database = FirebaseFirestore.instance;

  //Adds a product to database
  addProduct(Product product) {
    database.collection("products").doc().set(product.toFirestore());
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

  //Async. get all products from a given category.
  Future<List<Product>> getProductsByCategory(Categories category) async {
    return await database
        .collection("products")
        .where("category", isEqualTo: category.name)
        .get()
        .then((querySnapshot) => _fromQuerySnapshotToProducts(querySnapshot));
  }

  //Async. get all products from a given manufacture.
  Future<List<Product>> getProductsByManufacture(
      Manufacturers manufacture) async {
    return await database
        .collection("products")
        .where("manufacture", isEqualTo: manufacture.name)
        .get()
        .then((querySnapshot) => _fromQuerySnapshotToProducts(querySnapshot));
  }

  // Gets all products from the database and creates Products objects and add them to dummydata list.
  getAllProducts() async {
    await database.collection("products").get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Product product = Product.fromFirestore(docSnapshot);
        products.add(product); //Todo: Replace this.
      }
    });
  }

  //Untested workaround. Firebase do not support filter by search.
  findProductsByTitle(String searchText) {
    return database
        .collection("products")
        .where("title", isGreaterThanOrEqualTo: searchText)
        .where("title", isLessThanOrEqualTo: "$searchText\uf7ff")
        .get();
  }
}
