import 'package:flutter/material.dart';

import 'package:restuarant_ui/const/menu.dart';
import 'package:restuarant_ui/modal/order_item.dart';
import 'package:restuarant_ui/views/widgets/build_store_bottom_sheet_content.dart';
import 'package:restuarant_ui/views/widgets/food_item.dart';

class FoodItemListViewBuilder extends StatelessWidget {
  final String foodType;

  const FoodItemListViewBuilder({
    super.key,
    required this.foodType,
  });

  @override
  Widget build(BuildContext context) {
    final List foodList =
        menu.where((item) => item.foodType == foodType).toList();
    return ListView.separated(
      shrinkWrap: true,
      itemCount: foodList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: (){showBottomSheet(foodList[index], context);},
        child: FoodItem(orderItem: foodList[index]),
      ),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

void showBottomSheet(OrderItem orderItem, BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return BuildStoreBottomSheetContent(orderItem: orderItem);
    },
  );
}