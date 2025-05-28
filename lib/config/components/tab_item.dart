import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String text;
  final bool isSelected;

  const TabItem({
    super.key,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 4),
        if (isSelected)
          Container(
            height: 2,
            width: 40,
            color: Colors.blue,
          ),
      ],
    );
  }
}
