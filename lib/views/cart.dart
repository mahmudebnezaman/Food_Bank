import 'package:flutter/material.dart';
import 'package:restuarant_ui/modal/order_item.dart';
import 'package:restuarant_ui/views/widgets/quantity_changer_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  double price = 0;

  Future<List<OrderItem>> loadCartItemsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = prefs.getStringList('cartItems');
    if (encodedList != null) {
      return encodedList.map((item) => OrderItem.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveCartItemsToPrefs(List<OrderItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = items.map((item) => item.toJsonString()).toList();
    // print('saved value: $encodedList');
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
          child: FutureBuilder<List<OrderItem>>(
            future: loadCartItemsFromPrefs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No items in the cart'));
              } else {
                final cartItems = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) => Card(
                          clipBehavior: Clip.antiAlias,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  cartItems.remove(cartItems[index]);
                                  saveCartItemsToPrefs(cartItems);
                                  loadCartItemsFromPrefs();
                                  setState(() {});
                                },
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
                              Image.network(
                                cartItems[index].foodImage,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                                isAntiAlias: true,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItems[index].foodName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Text(
                                      cartItems[index].foodDetails,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  children: [
                                    QuantityChangerButton(
                                      decreaseFunction: () {
                                        setState(() {
                                          cartItems[index].quantity--;
                                        });
                                      },
                                      increaseFunction: () {},
                                      quantity: cartItems[index].quantity,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '\$ ${cartItems[index].price}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price Details'),
                              Divider(),
                              Row(
                                children: [
                                  Text('Sub total'),
                                  Spacer(),
                                  Text('\$100'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Service Fee'),
                                  Spacer(),
                                  Text('\$1'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Delivery Charge'),
                                  Spacer(),
                                  Text('\$10'),
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
              '\$ 100.0',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('CHECKOUT'),
            ),
          ],
        ),
      ),
    );
  }

  //   void increaseFunctionality(quantity, price) {
  //   quantity++;
  //   price =  price * quantity;
  //   setState(() {});
  // }

  // void decreaseFunctionality() {
  //   if (quantity > 1) {
  //     quantity--;
  //     calculatedPrice = widget.orderItem.price * quantity;
  //     setState(() {});
  //   }
  // }
}
