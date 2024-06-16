import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StoreCard extends StatelessWidget {
  final String storeImage;
  final String storeName;
  final String address;

  const StoreCard({
    super.key, required this.storeImage,required this.storeName,required this.address
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: Image.asset(
              storeImage,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 15,
                    ),
                    Text(
                      '(4.5)',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 15,
                    ),
                    const Gap(2),
                    Text(
                      address,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.delivery_dining,
                      size: 15,
                    ),
                    const Gap(2),
                    Text(
                      'Free Delivery',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.timer_rounded,
                      size: 15,
                    ),
                    const Gap(2),
                    Text(
                      '20-30 minutes',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
