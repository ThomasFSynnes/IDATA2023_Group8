import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton(
      {super.key,
      required this.navigateTo,
      required this.title,
      required this.icon,
      required this.color});

  final MaterialPageRoute navigateTo;
  final String title;
  final Icon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          backgroundColor: color),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(navigateTo);
      },
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
