import 'package:flutter/material.dart';
import 'package:restuarant_ui/views/cart.dart';
import 'package:restuarant_ui/views/page_zero.dart';

class RestaurantHomeView extends StatefulWidget {
  const RestaurantHomeView({super.key, required this.title});

  final String title;

  @override
  State<RestaurantHomeView> createState() => _RestaurantHomeViewState();
}

class _RestaurantHomeViewState extends State<RestaurantHomeView> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    // const Dashboard(),
    const PageZero(),
    const CartView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // body: IndexedStack(
      //   index: _selectedIndex,
      //   children: _widgetOptions,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}