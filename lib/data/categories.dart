import 'package:user_manuals_app/model/category.dart';

const categories = {
  Categories.SmartPhones: Category(
      id: 'c1', title: 'Smart Phones', imageUrl: 'assets/categories/phone.png', type:Categories.SmartPhones),
  Categories.Laptops: Category(
      id: 'c2', title: 'Laptops', imageUrl: 'assets/categories/laptop.png', type:Categories.Laptops),
  Categories.Speakers: Category(
      id: 'c3', title: 'Speakers', imageUrl: 'assets/categories/speaker.png',type:Categories.Speakers),
  Categories.Fridge: Category(
      id: 'c4', title: 'Fridges', imageUrl: 'assets/categories/fridge.png',type:Categories.Fridge),
  Categories.Microphone: Category(
      id: 'c5',
      title: 'Microphones',
      imageUrl: 'assets/categories/microphone.png',type:Categories.Microphone),
  Categories.Tablets: Category(
      id: 'c6', title: 'Tablets', imageUrl: 'assets/categories/tablet.png',type:Categories.Tablets),
  Categories.SmartWatch: Category(
      id: 'c7',
      title: 'Smart Watch',
      imageUrl: 'assets/categories/smartwatch.png',type:Categories.SmartWatch),
  Categories.Monitors: Category(
      id: 'c8', title: 'Monitors', imageUrl: 'assets/categories/monitor.png',type:Categories.Monitors),
  Categories.Microwave: Category(
      id: 'c9',
      title: 'Microwave',
      imageUrl: 'assets/categories/microwave.png',type:Categories.Microwave),
  Categories.Others: Category(
      id: 'c10', title: 'Others', imageUrl: 'assets/categories/others.png',type:Categories.Others),
};

List<Categories> categoriesList = [
  Categories.Fridge,
  Categories.Laptops,
  Categories.Microphone,
  Categories.Microwave,
  Categories.Monitors,
  Categories.SmartPhones,
  Categories.SmartWatch,
  Categories.Speakers,
  Categories.Tablets,
  Categories.Others
  // Add other Manufacturers values as needed
];

List<Category> categoryObjects = categoriesList.map((category) {
  return categories[category]!;
}).toList();
