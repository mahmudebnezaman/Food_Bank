import 'package:flutter/material.dart';
Widget foodItem({imageUrl}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 45,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                imageUrl,
              ),
            ),
          ),
        ),
        const CircleAvatar(
          radius: 12,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Colors.orange,
              size: 20,
            ),
          ),
        ),
      ],
    ),
  );
}
