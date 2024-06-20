import 'package:flutter/material.dart';
import 'package:restuarant_ui/modal/order_item.dart';
import 'package:restuarant_ui/views/widgets/build_cart_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final ValueNotifier<List<OrderItem>> cartItemsNotifier = ValueNotifier([]);

  double subTotal = 0;

  @override
  void initState() {
    super.initState();
    loadCartItemsFromPrefs();
  }

  void getSubTotal() {
    subTotal = 0;
    for (OrderItem item in cartItemsNotifier.value) {
      subTotal += item.price * item.quantity;
    }
    setState(() {});
  }

  Future<void> loadCartItemsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = prefs.getStringList('cartItems');
    if (encodedList != null) {
      final cartItems =
          encodedList.map((item) => OrderItem.fromJson(item)).toList();
      cartItemsNotifier.value = cartItems;
      getSubTotal();
    }
  }

  Future<void> saveCartItemsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList =
        cartItemsNotifier.value.map((item) => item.toJsonString()).toList();
    await prefs.setStringList('cartItems', encodedList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders!!'),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder<List<OrderItem>>(
            valueListenable: cartItemsNotifier,
            builder: (context, cartItems, _) {
              if (cartItems.isEmpty) {
                return const Center(child: Text('No items in the cart'));
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) => CartItemCard(
                          orderItem: cartItems[index],
                          onDelete: () {
                            cartItems.removeAt(index);
                            cartItemsNotifier.value = List.from(cartItems);
                            saveCartItemsToPrefs();
                            getSubTotal();
                          },
                          onQuantityChange: (newQuantity) {
                            cartItems[index].quantity = newQuantity;
                            cartItemsNotifier.value = List.from(cartItems);
                            saveCartItemsToPrefs();
                            getSubTotal();
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Price Details'),
                              const Divider(),
                              Row(
                                children: [
                                  const Text('Sub total'),
                                  const Spacer(),
                                  Text('\$ $subTotal'),
                                ],
                              ),
                              const Row(
                                children: [
                                  Text('Service Fee'),
                                  Spacer(),
                                  Text('\$1'),
                                ],
                              ),
                              const Row(
                                children: [
                                  Text('Delivery Charge'),
                                  Spacer(),
                                  Text('\$0.0'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
        child: Row(
          children: [
            Text(
              '\$ $subTotal',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('CHECKOUT'),
            ),
          ],
        ),
      ),
    );
  }
}