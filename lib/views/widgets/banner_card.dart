import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:restuarant_ui/const/images.dart';

class OrderTypeCard extends StatelessWidget {
  final String image;
  final String title;

  const OrderTypeCard({
    super.key,
    required this.image,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                image,
                height: 40,
              ),
            ),
            // const Gap(2),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


Row buildOrderTypeRow() {
  return Row(
    children: [
      OrderTypeCard(image: dineInImage, title: 'Dine-In'),
      const Gap(10),
      OrderTypeCard(
          image: homeDeliveryImage, title: 'Home\nDelivery'),
      const Gap(10),
      OrderTypeCard(image: takeAwayImage, title: 'Take\nAway'),
    ],
  );
}
