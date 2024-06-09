import 'package:flutter/material.dart';
import 'package:restuarant_ui/entities/order_item.dart';
import 'package:restuarant_ui/views/food_details.dart';
import 'package:restuarant_ui/views/widgets/food_item.dart';

Widget buildCategoryCard(
    {required String title, required List <OrderItem> orderItem, required BuildContext context}) {
  return Column(
    children: [
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const FoodDetails()));
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          color: Colors.white,
          child: SizedBox(
            height: 390,
            width: 100,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) => foodItem(imageUrl: orderItem[index].foodImage),
              itemCount: orderItem.length,
            ),
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
