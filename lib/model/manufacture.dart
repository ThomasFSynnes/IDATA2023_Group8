class Manufacture {
  const Manufacture(
      {required this.id, required this.title, required this.imageUrl});

  final String id;
  final String title;
  final String imageUrl;
}

enum Manufacturers {
  Apple,
  Acer,
  Samsung,
  Rode,
  Dell,
  Sony,
  Lenovo,
  LG,
  HP,
  Others
}
