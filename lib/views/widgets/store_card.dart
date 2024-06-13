import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:restuarant_ui/const/images.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(bannermage,isAntiAlias: true, height: 200, width: 300, fit: BoxFit.cover,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Pizza House', style: Theme.of(context).textTheme.titleLarge,),
                    const Gap(5),
                    const Icon(Icons.star, color: Colors.orange,),
                    const Text('4.5'),
                  ],
                ),
                Row(
                  children: [
                    Text('Naryanganj', style: Theme.of(context).textTheme.bodyMedium,),
                    const Icon(Icons.location_pin, size: 14,),
                  ],
                ),
                const Row(
                  children: [
                    Icon(Icons.delivery_dining),
                    Gap(2),
                    Text('Free Delivery'),
                    Gap(30),
                    Icon(Icons.timer_outlined),Gap(2),
                    Text('20-30 minutes'),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
