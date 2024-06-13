import 'package:flutter/material.dart';
import 'package:restuarant_ui/const/menu.dart';
import 'package:restuarant_ui/views/widgets/build_category_card.dart';
import 'package:restuarant_ui/views/widgets/searc_bar.dart';

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
                CustomSearchBar(height: height, width: width, bannerText: 'Shop Name',),
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

