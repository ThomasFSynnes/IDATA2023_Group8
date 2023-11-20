class Manufacture {
  const Manufacture(
      {required this.id, required this.title, required this.imageUrl, required this.type});

  final String id;
  final String title;
  final String imageUrl;
  final Manufacturers type;
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
