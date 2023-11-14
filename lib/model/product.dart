import 'package:user_manuals_app/model/category.dart';
import 'package:user_manuals_app/model/manufacture.dart';

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
}
