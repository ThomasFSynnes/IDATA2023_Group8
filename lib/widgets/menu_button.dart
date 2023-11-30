import 'package:flutter/material.dart';

//**
// Flutter widget for menu buttons
// a elevated button with styling, takes title, icon, color and navigate to
// */

class MenuButton extends StatelessWidget {
  const MenuButton(
      {super.key,
      required this.navigateTo, //page to navigate to
      required this.title, //text for button
      required this.icon, //icon for button
      required this.color}); //color of button

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
