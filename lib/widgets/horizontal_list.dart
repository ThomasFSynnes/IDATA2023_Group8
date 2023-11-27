import 'package:flutter/material.dart';
import 'package:user_manuals_app/widgets/display_card.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({
    super.key,
    required this.list,
  });

  final List list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(12),
        itemCount: list.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 12,
          );
        },
        itemBuilder: (context, index) {
          return DisplayCard(item: list[index]);
        },
      ),
    );
  }
}