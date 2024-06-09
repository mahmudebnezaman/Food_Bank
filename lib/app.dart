import 'package:flutter/material.dart';
import 'package:restuarant_ui/views/home_view.dart';

class RestaurantUI extends StatelessWidget {
  const RestaurantUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home:const RestaurantHomeView(title: 'UI',),
    );
  }
}