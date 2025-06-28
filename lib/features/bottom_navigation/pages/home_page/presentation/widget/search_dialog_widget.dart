//import 'dart:ffi';

import 'package:flutter/material.dart';

class SearchDialogWidget extends StatelessWidget {
  SearchDialogWidget({super.key, required this.onSearch});

  final Function(String) onSearch;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search News'),
      content: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Enter keywords...',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onSearch(_searchController.text);
          },
          child: const Text('Search'),
        ),
      ],
    );
  }
}
