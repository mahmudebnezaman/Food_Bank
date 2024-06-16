import 'package:flutter/material.dart';
import 'package:restuarant_ui/const/menu.dart';
import 'package:restuarant_ui/modal/order_item.dart';
import 'package:restuarant_ui/views/food_details.dart';
import 'package:restuarant_ui/views/widgets/food_item.dart';

Widget buildCategoryCard(
    {required String title,
    required List<OrderItem> orderItem,
    required BuildContext context,
    }) {
  double height = MediaQuery.sizeOf(context).height * 0.45;
  double width = MediaQuery.sizeOf(context).width * 0.3;
  return Column(
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(
        height: 10,
      ),
      Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        color: Colors.white,
        child: SizedBox(
          height: height,
          width: width,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodDetails(
                              orderItem: orderItem[index],
                            )));
              },
              child: FoodItem(orderItem: menu[index],),
            ),
            itemCount: orderItem.length,
          ),
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_downward,
          color: Colors.orange,
        ),
      ),
    ],
  );
}
