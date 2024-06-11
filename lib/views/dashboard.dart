import 'package:flutter/material.dart';
import 'package:restuarant_ui/const/images.dart';
import 'package:restuarant_ui/const/menu.dart';
import 'package:restuarant_ui/views/widgets/build_category_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
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
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildCategoryCard(title: 'Breakfast', orderItem: breakfastMenu, context: context),
                    buildCategoryCard(title: 'Lunch', orderItem: lunchMenu, context: context),
                    buildCategoryCard(title: 'Dinner', orderItem: dinnerMenu, context: context),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}