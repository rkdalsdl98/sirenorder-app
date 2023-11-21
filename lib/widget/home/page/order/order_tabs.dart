import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/home/page/order/order_tab.dart';

class OrderTabs extends StatelessWidget {
  final int currIndex;
  final void Function(int index) onChangeTab;

  const OrderTabs({
    super.key,
    required this.currIndex,
    required this.onChangeTab,
  });

  @override
  Widget build(BuildContext context) {
    int tabCount = 0;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.5),
            width: 2,
          ),
        ),
      ),
      width: double.maxFinite,
      height: 30 * getScaleHeight(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: ["전체메뉴", "나만의 메뉴"].map<OrderTab>(
          (text) {
            final int index = tabCount;
            ++tabCount;
            return OrderTab(
              text: text,
              selTab: index == currIndex,
              onChangeTab: onChangeTab,
              tabIndex: index,
            );
          },
        ).toList(),
      ),
    );
  }
}
