import 'package:flutter/material.dart';
import 'package:user_manuals_app/data/dummy_data.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text(availableCategories[1].title),
            const SizedBox(height: 20),
            Image.asset(availableCategories[3].imageUrl),
            Image.asset(availableManufactures[2].imageUrl),
            Image.asset(availableProducts[2].imageUrl)
          ],
        ),
      ),
    );
  }
}
