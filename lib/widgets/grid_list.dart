import 'package:flutter/material.dart';
import 'package:user_manuals_app/widgets/display_card.dart';

class GridList extends StatelessWidget {
  const GridList({
    super.key,
    required this.list,
  });

  final List list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return DisplayCard(item: list[index]);
      },
    );
  }
}
