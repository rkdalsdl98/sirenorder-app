import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/home/page/order/order_page_all_menu.dart';
import 'package:sirenorder_app/widget/home/page/order/order_page_my_menu.dart';
import 'package:sirenorder_app/widget/home/page/order/order_tabs.dart';

class OrderPageBody extends StatefulWidget {
  const OrderPageBody({
    super.key,
  });

  @override
  State<OrderPageBody> createState() => _OrderPageBodyState();
}

class _OrderPageBodyState extends State<OrderPageBody> {
  int currTabIndex = 0;

  void onChangeTab(int index) => setState(() {
        currTabIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 465 * getScaleHeight(context),
      child: Column(
        children: [
          OrderTabs(
            currIndex: currTabIndex,
            onChangeTab: onChangeTab,
          ),
          IndexedStack(
            index: currTabIndex,
            children: const [
              OrderAllMenu(),
              OrderMyMenu(),
            ],
          )
        ],
      ),
    );
  }
}
