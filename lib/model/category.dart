class Category {
  const Category(
      {required this.id, required this.title, required this.imageUrl});

  final String id;
  final String title;
  final String imageUrl;
}

enum Categories {
  SmartPhones,
  Laptops,
  Speakers,
  Microphone,
  Tablets,
  SmartWatch,
  Monitors,
  Fridge,
  Microwave,
  Others
}
