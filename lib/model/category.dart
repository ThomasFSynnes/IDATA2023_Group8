//**
// Class representing categories for products
//
// id: Represents a unique identifier for each category.
// title: Describes the name or title of the category (e.g., "Smart Phones").
// imageUrl: Refers to the URL or path pointing to the image associated with the category.
// type: Indicates the specific type of the category, utilizing the Categories enum.
// */

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
