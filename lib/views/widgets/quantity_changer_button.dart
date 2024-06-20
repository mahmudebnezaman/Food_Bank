import 'package:flutter/material.dart';

class QuantityChangerButton extends StatefulWidget {
  final Function(int) valueChangerFunction;
  final int quantity;

  const QuantityChangerButton({
    super.key,
    required this.valueChangerFunction,
    required this.quantity,
  });

  @override
  QuantityChangerButtonState createState() => QuantityChangerButtonState();
}

class QuantityChangerButtonState extends State<QuantityChangerButton> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.quantity;
  }

  void _increment() {
    setState(() {
      value++;
      widget.valueChangerFunction(value);
    });
  }

  void _decrement() {
    setState(() {
      if (value > 1) {
        value--;
        widget.valueChangerFunction(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildAmountChangeIconButton(
          onTap: _decrement,
          icon: Icons.remove_rounded,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            '$value',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        buildAmountChangeIconButton(
          onTap: _increment,
          icon: Icons.add_rounded,
        ),
      ],
    );
  }

  CircleAvatar buildAmountChangeIconButton({required void Function() onTap, required IconData icon}) {
    return CircleAvatar(
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon),
      ),
    );
  }
}
