import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
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
          const SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
