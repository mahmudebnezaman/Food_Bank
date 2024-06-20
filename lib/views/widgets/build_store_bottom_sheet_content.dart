import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:restuarant_ui/modal/order_item.dart';

import 'package:restuarant_ui/views/widgets/quantity_changer_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuildStoreBottomSheetContent extends StatefulWidget {
  final OrderItem orderItem;

  const BuildStoreBottomSheetContent({
    super.key,
    required this.orderItem,
  });

  @override
  State<BuildStoreBottomSheetContent> createState() =>
      _BuildStoreBottomSheetContentState();
}

class _BuildStoreBottomSheetContentState
    extends State<BuildStoreBottomSheetContent> {
  double price = 0;
  List<OrderItem> cartItems = [];
  int quantity = 1;
  bool isLoading = true;

  Future<void> loadCartItemsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = prefs.getStringList('cartItems');
    if (encodedList != null) {
      cartItems = encodedList.map((item) => OrderItem.fromJson(item)).toList();
      checkIfItemExistsInCart();
    }
    setState(() {
      isLoading = false;
    });
  }

  void checkIfItemExistsInCart() {
    for (var item in cartItems) {
      if (item.foodName == widget.orderItem.foodName) {
        quantity = item.quantity;
        log(quantity.toString());
        price = item.price * quantity;
        setState(() {});
        return;
      }
    }
    price = widget.orderItem.price * widget.orderItem.quantity;
    quantity = widget.orderItem.quantity;
    setState(() {});
  }

  Future<void> saveCartItemsToPrefs(List<OrderItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = items.map((item) => item.toJsonString()).toList();
    await prefs.setStringList('cartItems', encodedList);
  }

  @override
  void initState() {
    super.initState();
    loadCartItemsFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  widget.orderItem.foodImage,
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                  isAntiAlias: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      widget.orderItem.foodName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Spacer(),
                    Text(
                      '\$ $price',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.orderItem.foodDetails,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                const Divider(),
                Row(
                  children: [
                    QuantityChangerButton(
                      valueChangerFunction: (value) {
                        quantity = value;
                        price = widget.orderItem.price * value;
                        setState(() {});
                      },
                      quantity: quantity,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          textStyle: Theme.of(context).textTheme.titleLarge,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                        onPressed: () async {
                          bool itemExists = false;
                          for (OrderItem item in cartItems) {
                            if (item.foodName == widget.orderItem.foodName) {
                              item.quantity = quantity;
                              itemExists = true;
                              break;
                            }
                          }
                          if (!itemExists) {
                            cartItems.add(
                              OrderItem(
                                foodType: widget.orderItem.foodType,
                                foodName: widget.orderItem.foodName,
                                foodImage: widget.orderItem.foodImage,
                                foodDetails: widget.orderItem.foodDetails,
                                quantity: quantity,
                                price: widget.orderItem.price,
                              ),
                            );
                          }
                          await saveCartItemsToPrefs(cartItems);
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '$quantity ${widget.orderItem.foodName} added to your cart.',
                              ),
                            ),
                          );
                        },
                        child: const Text('Add to Cart'),
                      ),
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
