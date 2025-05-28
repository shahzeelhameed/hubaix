import 'package:flutter/material.dart';
import 'package:hubaix/config/components/tab_item.dart';

class NavigationTabs extends StatelessWidget {
  const NavigationTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [TabItem(text: "Post", isSelected: true)],
      ),
    );
  }
}
