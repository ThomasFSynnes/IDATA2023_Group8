import 'package:user_manuals_app/model/manufacture.dart';

const manufactures = {
  Manufacturers.Apple: Manufacture(
      id: 'm1', title: 'Apple', imageUrl: 'assets/manufacture/apple.png', type: Manufacturers.Apple),
  Manufacturers.Acer: Manufacture(
      id: 'm2', title: 'Acer', imageUrl: 'assets/manufacture/acer.png', type: Manufacturers.Acer),
  Manufacturers.Samsung: Manufacture(
      id: 'm3', title: 'Samsung', imageUrl: 'assets/manufacture/samsung.png', type: Manufacturers.Samsung),
  Manufacturers.Dell: Manufacture(
      id: 'm4', title: 'Dell', imageUrl: 'assets/manufacture/dell.png', type: Manufacturers.Dell),
  Manufacturers.Rode: Manufacture(
      id: 'm5', title: 'Røde', imageUrl: 'assets/manufacture/rode.png', type: Manufacturers.Rode),
  Manufacturers.Sony: Manufacture(
      id: 'm6', title: 'Sony', imageUrl: 'assets/manufacture/sony.png', type: Manufacturers.Sony),
  Manufacturers.Lenovo: Manufacture(
      id: 'm7', title: 'Lenovo', imageUrl: 'assets/manufacture/lenovo.png', type: Manufacturers.Lenovo),
  Manufacturers.LG:
      Manufacture(id: 'm8', title: 'LG', imageUrl: 'assets/manufacture/LG.png', type: Manufacturers.LG),
  Manufacturers.HP:
      Manufacture(id: 'm9', title: 'HP', imageUrl: 'assets/manufacture/hp.png', type: Manufacturers.HP),
  Manufacturers.Others: Manufacture(
      id: 'm10', title: 'Others', imageUrl: 'assets/manufacture/others.png', type: Manufacturers.Others),
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
