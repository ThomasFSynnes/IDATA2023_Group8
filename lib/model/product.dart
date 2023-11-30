import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_manuals_app/data/categories.dart';
import 'package:user_manuals_app/data/manufacturers.dart';
import 'package:user_manuals_app/model/category.dart';
import 'package:user_manuals_app/model/manufacture.dart';

//**
// Class representing products
//
// id: Represents a unique identifier for each product
// category: referes to the category this product belongs to
// manufacture: referes to the manufacturer this product belongs to
// title: Describes the name or title of the manufacturer (e.g., "iPhone 7").
// imageUrl: Refers to the URL or path pointing to the image associated with the product
// pdfUrl: Refers to the URL or path pointing to the PDF/UserManual associated with the product
// modelNumber: Optional field for model number for the product
// releaseYear: Optional field for release year for the product
// */

class Product {
  const Product({
    required this.id,
    required this.category,
    required this.manufacture,
    required this.title,
    required this.imageUrl,
    required this.pdfUrl,
    this.modelNumber,
    this.releaseYear,
  });

  final String id;
  final Category category;
  final Manufacture manufacture;
  final String title;
  final String imageUrl;
  final String? releaseYear;
  final String? modelNumber;
  final String pdfUrl;

  factory Product.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    Categories categoryEnum =
        Categories.values.firstWhere((e) => e.name == data?['category']);
    Manufacturers manufacturerEnum =
        Manufacturers.values.firstWhere((e) => e.name == data?['manufacture']);

    return Product(
      id: snapshot.id,
      title: data?['title'],
      category: categories[categoryEnum]!,
      manufacture: manufactures[manufacturerEnum]!,
      imageUrl: data?['imageUrl'],
      releaseYear: data?['releaseYear'],
      modelNumber: data?['modelNumber'],
      pdfUrl: data?['pdfUrl'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "category": category.type.name,
      "manufacture": manufacture.type.name,
      "imageUrl": imageUrl,
      "releaseYear": releaseYear,
      "modelNumber": modelNumber,
      "pdfUrl": pdfUrl,
    };
  }
}
