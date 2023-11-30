//**
// Class representing manufacturer for products
//
// id: Represents a unique identifier for each manufacturer
// title: Describes the name or title of the manufacturer (e.g., "Apple").
// imageUrl: Refers to the URL or path pointing to the image associated with the manufacturer
// type: Indicates the specific type of the category, utilizing the Manufacturer enum.
// */

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
