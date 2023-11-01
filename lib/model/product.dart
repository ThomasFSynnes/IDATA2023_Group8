class Product {
  const Product({
    required this.id,
    required this.categories,
    required this.manufactures,
    required this.title,
    required this.imageUrl,
  });

  final String id;
  final List<String> categories;
  final List<String> manufactures;
  final String title;
  final String imageUrl;
}