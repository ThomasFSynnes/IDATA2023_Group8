import 'package:user_manuals_app/model/category.dart';
import 'package:user_manuals_app/model/manufacture.dart';
import 'package:user_manuals_app/model/product.dart';

const availableManufactures = [
  Manufacture(
      id: 'm1', title: 'Apple', imageUrl: 'assets/manufacture/apple.png'),
  Manufacture(id: 'm2', title: 'Acer', imageUrl: 'assets/manufacture/acer.png'),
  Manufacture(
      id: 'm3', title: 'Samsung', imageUrl: 'assets/manufacture/samsung.png'),
  Manufacture(id: 'm4', title: 'Dell', imageUrl: 'assets/manufacture/dell.png'),
  Manufacture(id: 'm5', title: 'Røde', imageUrl: 'assets/manufacture/rode.png'),
];

const availableCategories = [
  Category(
      id: 'c1', title: 'Smart Phones', imageUrl: 'assets/categories/phone.png'),
  Category(
      id: 'c2', title: 'Speakers', imageUrl: 'assets/categories/speaker.png'),
  Category(
      id: 'c3', title: 'Laptops', imageUrl: 'assets/categories/laptop.png'),
  Category(
      id: 'c4', title: 'Fridges', imageUrl: 'assets/categories/fridge.png'),
  Category(
      id: 'c5',
      title: 'Microphones',
      imageUrl: 'assets/categories/microphone.png'),
  Category(id: 'c6', title: 'Tablets', imageUrl: 'assets/categories/tablet.png')
];

const availableProducts = [
  Product(
      id: 'p1',
      categories: ['c1'],
      manufactures: ['m1'],
      title: 'IPhone 14',
      imageUrl: 'assets/products/iphone14.png'),
  Product(
      id: 'p2',
      categories: ['c1'],
      manufactures: ['m3'],
      title: 'Samsung Galaxy 22',
      imageUrl: 'assets/products/SamsungGalaxy22.png'),
  Product(
      id: 'p3',
      categories: ['c3'],
      manufactures: ['m2'],
      title: 'Acer Aspire 3',
      imageUrl: 'assets/products/aceraspire3.png'),
  Product(
      id: 'p4',
      categories: ['c6'],
      manufactures: ['m1'],
      title: 'IPad',
      imageUrl: 'assets/products/ipad.png')
];
