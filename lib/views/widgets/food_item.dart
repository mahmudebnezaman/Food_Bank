import 'package:flutter/material.dart';
Widget foodItem({imageUrl, foodName}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          child: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
              imageUrl,
            ),
          ),
        ),
        Text(foodName, textAlign: TextAlign.center,),
      ],
    ),
  );
}
