import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/home/page/order/menu_item.dart';
import 'package:sirenorder_app/widget/home/page/order/order_category.tabs.dart';

class OrderAllMenu extends StatefulWidget {
  const OrderAllMenu({
    super.key,
  });

  @override
  State<OrderAllMenu> createState() => _OrderAllMenuState();
}

class _OrderAllMenuState extends State<OrderAllMenu> {
  int currIndex = 0;
  void onChangeTab(int index) => setState(() {
        currIndex = index;
      });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 435 * getScaleHeight(context),
      child: Column(
        children: [
          OrderCategoryTabs(
            currIndex: currIndex,
            onChangeTab: onChangeTab,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: IndexedStack(
                index: currIndex,
                children: [
                  drinkListhelper(),
                  foodListhelper(),
                  productListhelper(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget drinkListhelper() {
  return const Padding(
    padding: EdgeInsets.only(top: 10),
    child: Column(
      children: [
        MenuItem(),
      ],
    ),
  );
}

Widget foodListhelper() {
  return const Padding(
    padding: EdgeInsets.only(top: 10),
    child: Column(
      children: [],
    ),
  );
}

Widget productListhelper() {
  return const Padding(
    padding: EdgeInsets.only(top: 10),
    child: Column(
      children: [],
    ),
  );
}
