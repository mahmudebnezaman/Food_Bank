import 'package:flutter/material.dart';

class QuantityChangerButton extends StatelessWidget {
  final VoidCallback increaseFunction;
  final VoidCallback decreaseFunction;
  final int quantity;

  const QuantityChangerButton({
    super.key,
    required this.decreaseFunction,
    required this.increaseFunction,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildAmountChangeIconButton(
            onTap: decreaseFunction, icon: Icons.remove_rounded),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '$quantity',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        buildAmountChangeIconButton(
            onTap: increaseFunction, icon: Icons.add_rounded),
      ],
    );
  }

  InkWell buildAmountChangeIconButton({onTap, icon}) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: CircleAvatar(
        radius: 15,
        child: Icon(
          icon,
          size: 20,
        ),
      ),
    );
  }
}
