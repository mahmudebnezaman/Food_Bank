import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:restuarant_ui/modal/order_item.dart';

Widget buildStoreBottomSheetContent(OrderItem orderItem, BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.3, // Adjust height as needed
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius:BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            orderItem.foodName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${orderItem.price}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              ElevatedButton(
                onPressed: () {
                  // Add to cart functionality here
                },
                child: const Text('Add to Cart'),
              ),
            ],
          ),
          const Divider(),
          Text(
            orderItem.foodDetails,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}