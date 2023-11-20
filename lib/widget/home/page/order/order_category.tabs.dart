import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/home/page/order/order.category.tab.dart';

class OrderCategoryTabs extends StatelessWidget {
  final int currIndex;
  final void Function(int index) onChangeTab;

  const OrderCategoryTabs({
    super.key,
    required this.currIndex,
    required this.onChangeTab,
  });

  @override
  Widget build(BuildContext context) {
    int categoryCount = 0;
    return SizedBox(
      width: double.maxFinite,
      height: 30 * getScaleHeight(context),
      child: Row(
        children: ["음료", "음식", "상품"].map<OrderCategoryTab>((text) {
          ++categoryCount;
          return OrderCategoryTab(
            text: text,
            selCategory: (categoryCount - 1) == currIndex,
            onChangeTab: onChangeTab,
          );
        }).toList(),
      ),
    );
  }
}
