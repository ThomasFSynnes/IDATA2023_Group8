class Category {
  const Category(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.type});

  final String id;
  final String title;
  final String imageUrl;
  final Categories type;
}

enum Categories {
  smartPhones,
  laptops,
  speakers,
  microphone,
  tablets,
  smartWatch,
  monitors,
  fridge,
  microwave,
  others
}
