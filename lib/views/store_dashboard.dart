import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:restuarant_ui/const/images.dart';
import 'package:restuarant_ui/modal/store.dart';
import 'package:restuarant_ui/views/widgets/banner_card.dart';
import 'package:restuarant_ui/views/widgets/search_bar.dart';

import 'widgets/food_item_listview_builder.dart';

class StoreDashboard extends StatelessWidget {
  final Store store;

  const StoreDashboard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        store.storeBanner,
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const CustomSearchBar(),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 7.0,
                              spreadRadius: 0.0,
                              // offset: const Offset(0, 5 ),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              store.storeName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.orange, size: 16),
                                Text(
                                  '(4.5)',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_pin,
                                    size: 16, color: Colors.white),
                                const Gap(2),
                                Text(
                                  store.address,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Icon(Icons.delivery_dining,
                                    size: 16, color: Colors.white),
                                Gap(2),
                                Text(
                                  'Free Delivery',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Icon(Icons.timer_rounded,
                                    size: 16, color: Colors.white),
                                Gap(2),
                                Text(
                                  '20-30 minutes',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                buildOrderTypeRow(),
                Row(
                  children: [
                    Text(
                      'Popular Items',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Gap(10),
                    Image.asset(fireImage, height: 20),
                  ],
                ),
                const TabBar(
                  tabs: [
                    Tab(text: 'Fast Food'),
                    Tab(text: 'Main Course'),
                    Tab(text: 'Appetizers'),
                    Tab(text: 'Desserts'),
                  ],
                  labelPadding: EdgeInsets.zero,
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      FoodItemListViewBuilder(foodType: 'Fast Food',),
                      FoodItemListViewBuilder(foodType: 'Main Course',),
                      FoodItemListViewBuilder(foodType: 'Appetizers',),
                      FoodItemListViewBuilder(foodType: 'Desserts',),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
