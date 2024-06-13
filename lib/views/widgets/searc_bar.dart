import 'package:flutter/material.dart';
import 'package:restuarant_ui/const/images.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.height,
    required this.width,
    required this.bannerText,
  });

  final double height;
  final double width;
  final String bannerText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            bannermage,
            height: height * 0.3,
            width: width,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
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
            ),
            // Text(
            //   bannerText,
            //   textAlign: TextAlign.start,
            //   style: TextStyle(
            //     fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //   ),
            // )
          ],
        )
      ],
    );
  }
}
