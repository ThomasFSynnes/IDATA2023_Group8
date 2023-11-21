import 'package:user_manuals_app/model/manufacture.dart';

const manufactures = {
  Manufacturers.apple: Manufacture(
      id: 'm1',
      title: 'Apple',
      imageUrl: 'assets/manufacture/apple.png',
      type: Manufacturers.apple),
  Manufacturers.acer: Manufacture(
      id: 'm2',
      title: 'Acer',
      imageUrl: 'assets/manufacture/acer.png',
      type: Manufacturers.acer),
  Manufacturers.samsung: Manufacture(
      id: 'm3',
      title: 'Samsung',
      imageUrl: 'assets/manufacture/samsung.png',
      type: Manufacturers.samsung),
  Manufacturers.dell: Manufacture(
      id: 'm4',
      title: 'Dell',
      imageUrl: 'assets/manufacture/dell.png',
      type: Manufacturers.dell),
  Manufacturers.rode: Manufacture(
      id: 'm5',
      title: 'Røde',
      imageUrl: 'assets/manufacture/rode.png',
      type: Manufacturers.rode),
  Manufacturers.sony: Manufacture(
      id: 'm6',
      title: 'Sony',
      imageUrl: 'assets/manufacture/sony.png',
      type: Manufacturers.sony),
  Manufacturers.lenovo: Manufacture(
      id: 'm7',
      title: 'Lenovo',
      imageUrl: 'assets/manufacture/lenovo.png',
      type: Manufacturers.lenovo),
  Manufacturers.lg: Manufacture(
      id: 'm8',
      title: 'LG',
      imageUrl: 'assets/manufacture/LG.png',
      type: Manufacturers.lg),
  Manufacturers.hp: Manufacture(
      id: 'm9',
      title: 'HP',
      imageUrl: 'assets/manufacture/hp.png',
      type: Manufacturers.hp),
  Manufacturers.others: Manufacture(
      id: 'm10',
      title: 'Others',
      imageUrl: 'assets/manufacture/others.png',
      type: Manufacturers.others),
};

List<Manufacturers> manufacturersList = [
  Manufacturers.apple,
  Manufacturers.acer,
  Manufacturers.dell,
  Manufacturers.hp,
  Manufacturers.lg,
  Manufacturers.lenovo,
  Manufacturers.rode,
  Manufacturers.samsung,
  Manufacturers.sony,
  Manufacturers.others
  // Add other Manufacturers values as needed
];

List<Manufacture> manufactureObjects = manufacturersList.map((manufacturer) {
  return manufactures[manufacturer]!;
}).toList();
