import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Colors.white,
        ),
        suffixIcon: const Icon(
          Icons.message,
          color: Colors.white,
        ),
        hintText: 'Find What You Want...',
        fillColor: Colors.orange,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
