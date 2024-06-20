import 'package:flutter/material.dart';
import 'package:restuarant_ui/views/splash_screen.dart';

class RestaurantUI extends StatelessWidget {
  const RestaurantUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          // labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
