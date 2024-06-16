import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:restuarant_ui/modal/order_item.dart';

class FoodItem extends StatelessWidget {
  final OrderItem orderItem;

  const FoodItem({
    super.key,
    required this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderItem.foodName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('\$ ${orderItem.price}', style: const TextStyle(color: Colors.orange),),
                    const Gap(2),
                    Wrap(
                      children: [
                        Text(
                          orderItem.foodDetails,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.fade,
                          softWrap: true,

                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  orderItem.foodImage,
                  height: MediaQuery.sizeOf(context).width * 0.2,
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
