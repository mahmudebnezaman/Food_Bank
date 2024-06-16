import 'package:flutter/material.dart';

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
