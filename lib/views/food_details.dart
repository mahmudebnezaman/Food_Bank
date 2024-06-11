import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';
import 'package:restuarant_ui/const/menu.dart';
import 'package:restuarant_ui/entities/order_item.dart';
// import 'package:restuarant_ui/views/widgets/quantity_changer_button.dart';

class FoodDetails extends StatefulWidget {
  const FoodDetails({super.key, required this.orderItem});
  final OrderItem orderItem;

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  double calculatedPrice = 0;
  List<OrderItem> cartItems = [];
  int quantity = 1;

  Future<void> loadCartItemsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = prefs.getStringList('cartItems');
    if (encodedList != null) {
      cartItems = encodedList.map((item) => OrderItem.fromJson(item)).toList();
      checkIfItemExistsInCart();
    }
  }

  void checkIfItemExistsInCart() {
    for (var item in cartItems) {
      if (item.foodName == widget.orderItem.foodName) {
        setState(() {
          quantity += item.quantity;
          calculatedPrice = item.price*quantity;
        });
        return;
      }
    }
    setState(() {
      calculatedPrice = widget.orderItem.price * widget.orderItem.quantity;
    });
  }


  Future<void> saveCartItemsToPrefs(List<OrderItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = items.map((item) => item.toJsonString()).toList();
    // print('saved value: $encodedList');
    await prefs.setStringList('cartItems', encodedList);
  }

  @override
  void initState() {
    super.initState();
    calculatedPrice = widget.orderItem.price * widget.orderItem.quantity;
    loadCartItemsFromPrefs();
    cartItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
        actions: const [
          Icon(Icons.favorite),
          SizedBox(
            width: 8,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 105,
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(widget.orderItem.foodImage),
                ),
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lunch',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.orderItem.foodName,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      const Gap(5),
                      Text(
                        '4.5(45 Reviews)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('\$ ${widget.orderItem.price} x $quantity'),
                      const Spacer(),
                      Text(
                        '\$ $calculatedPrice',
                        // style: Theme.of(context).textTheme.headlineMedium,
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .fontSize,
                          // fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      // QuantityChangerButton(
                      //   decreaseFunction: decreaseFunctionality,
                      //   increaseFunction: increaseFunctionality,
                      //   quantity: quantity,
                      // ),
                    ],
                  ),
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Divider(),
                  Text(
                    widget.orderItem.foodDetails,
                    textAlign: TextAlign.justify,
                  ),
                  const Divider(),
                  Text(
                    'Frequently ordered together',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Gap(10),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                    items: imageSliders,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (widget.orderItem.quantity == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order Quantity can\'t be 0')),
            );
            return;
          }

          bool itemExists = false;
          for (OrderItem item in cartItems) {
            if (item.foodName == widget.orderItem.foodName) {
              item.quantity = quantity;
              item.price = calculatedPrice;
              itemExists = true;
              break;
            }
          }

          if (!itemExists) {
            cartItems.add(
              OrderItem(
                dineTime: widget.orderItem.dineTime,
                foodName: widget.orderItem.foodName,
                foodImage: widget.orderItem.foodImage,
                foodDetails: widget.orderItem.foodDetails,
                quantity: quantity,
                price: calculatedPrice,
              ),
            );
          }


          setState(() {});
          await saveCartItemsToPrefs(cartItems);

          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '$quantity ${widget.orderItem.foodName} added to your cart.',
              ),
            ),
          );
        },
        label: const Text(
          'Add to Cart',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  final List<Widget> imageSliders = lunchMenu
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item.foodImage,
                        fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          item.foodName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();

  // void increaseFunctionality() {
  //   quantity++;
  //   calculatedPrice = widget.orderItem.price * quantity;
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
