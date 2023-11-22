import 'package:user_manuals_app/model/category.dart';
import 'package:user_manuals_app/model/manufacture.dart';
import 'package:user_manuals_app/model/product.dart';
import 'package:user_manuals_app/data/categories.dart';
import 'package:user_manuals_app/data/manufacturers.dart';

var products = [
  Product(
      id: 'p4',
      category: categories[Categories.tablets]!,
      manufacture: manufactures[Manufacturers.apple]!,
      title: 'iPad Pro 12.9-inch (3rd generation)',
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/usermanual-app.appspot.com/o/images%2F2023-11-22%2019%3A24%3A11.066854?alt=media&token=e4af1f6d-5641-4441-9372-cc63b748bd87",
      pdfUrl:
          "https://firebasestorage.googleapis.com/v0/b/usermanual-app.appspot.com/o/files%2F2023-11-22%2019%3A24%3A28.414463?alt=media&token=0a71d8a6-d909-4ff4-be01-f6d7b11cabaf",
      modelNumber: "A1876",
      releaseYear: "2018"),
];
