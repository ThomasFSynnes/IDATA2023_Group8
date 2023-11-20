import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_manuals_app/data/dummy_data.dart';
import 'package:user_manuals_app/model/product.dart';

class DatabaseManager {
  final database = FirebaseFirestore.instance;

  addProduct(Product product) {
    database.collection("products").doc().set(product.toFirestore());
  }


  getAllProducts() async {
    await database.collection("products").get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        Product product = Product.fromFirestore(docSnapshot);
        products.add(product);
      }
    });
  }

  findProductsByTitle(String searchText) {
    return database
        .collection("products")
        .where("title", isGreaterThanOrEqualTo: searchText)
        .where("title", isLessThanOrEqualTo: "$searchText\uf7ff")
        .get();
  }
}
