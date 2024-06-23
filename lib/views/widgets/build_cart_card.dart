import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:restuarant_ui/modal/order_item.dart';
import 'package:restuarant_ui/views/widgets/quantity_changer_button.dart';

class CartItemCard extends StatelessWidget {
  final OrderItem orderItem;
  final VoidCallback onDelete;
  final ValueChanged<int> onQuantityChange;

  const CartItemCard({
    super.key,
    required this.orderItem,
    required this.onDelete,
    required this.onQuantityChange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => confirmDeleteDialog(context),
              );
            },
            // onTap: onDelete,
            child: Container(
              color: Colors.amber.shade200,
              height: 100,
              child: const Icon(
                Icons.delete_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Image.asset(
            orderItem.foodImage,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            isAntiAlias: true,
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderItem.foodName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Text(
                  'Free Delivery',
                ),
                Text(
                  '\$ ${orderItem.price} x ${orderItem.quantity}',
                  style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 12,
                    // color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '\$ ${orderItem.price * orderItem.quantity}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.orange,
                ),
              ),
              // const Spacer(),
              QuantityChangerButton(
                valueChangerFunction: (value) {
                  onQuantityChange(value);
                },
                quantity: orderItem.quantity,
              ),
            ],
          ),
        ],
      ),
    );
  }

  AlertDialog confirmDeleteDialog(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    title: Column(
      children: [
        const Icon(
          Icons.warning_amber_rounded,
          color: Colors.orange,
          size: 40,
        ),
        const SizedBox(height: 10),
        Text(
          'Delete Food Item',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    content: Text(
      'Are you sure you want to remove this item from your cart?',
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: TextAlign.center,
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'Cancel',
          style: TextStyle(
            color: Colors.grey.shade700,
          ),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          onDelete();
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Delete'),
      ),
    ],
  );
}

}
