import 'package:user_manuals_app/model/manufacture.dart';

const manufactures = {
  Manufacturers.Apple: Manufacture(
      id: 'm1', title: 'Apple', imageUrl: 'assets/manufacture/apple.png'),
  Manufacturers.Acer: Manufacture(
      id: 'm2', title: 'Acer', imageUrl: 'assets/manufacture/acer.png'),
  Manufacturers.Samsung: Manufacture(
      id: 'm3', title: 'Samsung', imageUrl: 'assets/manufacture/samsung.png'),
  Manufacturers.Dell: Manufacture(
      id: 'm4', title: 'Dell', imageUrl: 'assets/manufacture/dell.png'),
  Manufacturers.Rode: Manufacture(
      id: 'm5', title: 'Røde', imageUrl: 'assets/manufacture/rode.jpg'),
  Manufacturers.Sony: Manufacture(
      id: 'm6', title: 'Sony', imageUrl: 'assets/manufacture/sony.jpg'),
  Manufacturers.Lenovo: Manufacture(
      id: 'm7', title: 'Lenovo', imageUrl: 'assets/manufacture/lenovo.jpg'),
  Manufacturers.LG:
      Manufacture(id: 'm8', title: 'LG', imageUrl: 'assets/manufacture/LG.jpg'),
  Manufacturers.HP:
      Manufacture(id: 'm9', title: 'HP', imageUrl: 'assets/manufacture/HP.jpg'),
  Manufacturers.Others: Manufacture(
      id: 'm10', title: 'Others', imageUrl: 'assets/manufacture/Others.jpg'),
};

List<Manufacturers> manufacturersList = [
  Manufacturers.Apple,
  Manufacturers.Acer,
  Manufacturers.Dell,
  Manufacturers.HP,
  Manufacturers.LG,
  Manufacturers.Lenovo,
  Manufacturers.Rode,
  Manufacturers.Samsung,
  Manufacturers.Sony,
  Manufacturers.Others
  // Add other Manufacturers values as needed
];

List<Manufacture> manufactureObjects = manufacturersList.map((manufacturer) {
  return manufactures[manufacturer]!;
}).toList();
