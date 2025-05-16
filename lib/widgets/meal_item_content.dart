import 'package:flutter/material.dart';

class MealItemContent extends StatelessWidget {
  const MealItemContent({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16.0),
        SizedBox(width: 4.0),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
