class Manufacture {
  const Manufacture(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.type});

  final String id;
  final String title;
  final String imageUrl;
  final Manufacturers type;
}

enum Manufacturers {
  apple,
  acer,
  samsung,
  rode,
  dell,
  sony,
  lenovo,
  lg,
  hp,
  others
}
