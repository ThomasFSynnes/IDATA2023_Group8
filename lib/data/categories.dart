import 'package:user_manuals_app/model/category.dart';

const categories = {
  Categories.smartPhones: Category(
      id: 'c1',
      title: 'Smart Phones',
      imageUrl: 'assets/categories/phone.png',
      type: Categories.smartPhones),
  Categories.laptops: Category(
      id: 'c2',
      title: 'Laptops',
      imageUrl: 'assets/categories/laptop.png',
      type: Categories.laptops),
  Categories.speakers: Category(
      id: 'c3',
      title: 'Speakers',
      imageUrl: 'assets/categories/speaker.png',
      type: Categories.speakers),
  Categories.fridge: Category(
      id: 'c4',
      title: 'Fridges',
      imageUrl: 'assets/categories/fridge.png',
      type: Categories.fridge),
  Categories.microphone: Category(
      id: 'c5',
      title: 'Microphones',
      imageUrl: 'assets/categories/microphone.png',
      type: Categories.microphone),
  Categories.tablets: Category(
      id: 'c6',
      title: 'Tablets',
      imageUrl: 'assets/categories/tablet.png',
      type: Categories.tablets),
  Categories.smartWatch: Category(
      id: 'c7',
      title: 'Smart Watch',
      imageUrl: 'assets/categories/smartwatch.png',
      type: Categories.smartWatch),
  Categories.monitors: Category(
      id: 'c8',
      title: 'Monitors',
      imageUrl: 'assets/categories/monitor.png',
      type: Categories.monitors),
  Categories.microwave: Category(
      id: 'c9',
      title: 'Microwave',
      imageUrl: 'assets/categories/microwave.png',
      type: Categories.microwave),
  Categories.others: Category(
      id: 'c10',
      title: 'Others',
      imageUrl: 'assets/categories/others.png',
      type: Categories.others),
};

List<Categories> categoriesList = [
  Categories.fridge,
  Categories.laptops,
  Categories.microphone,
  Categories.microwave,
  Categories.monitors,
  Categories.smartPhones,
  Categories.smartWatch,
  Categories.speakers,
  Categories.tablets,
  Categories.others
  // Add other Manufacturers values as needed
];

List<Category> categoryObjects = categoriesList.map((category) {
  return categories[category]!;
}).toList();
