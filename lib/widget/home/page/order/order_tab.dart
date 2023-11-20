import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class OrderTab extends StatelessWidget {
  final String text;
  final int tabIndex;
  final bool selTab;
  final void Function(int index) onChangeTab;

  const OrderTab({
    super.key,
    required this.text,
    required this.selTab,
    required this.onChangeTab,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChangeTab(tabIndex);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: selTab
                ? const BorderSide(
                    color: Color(0xFF00704A),
                    width: 4,
                  )
                : BorderSide.none,
          ),
        ),
        width: 80 * getScaleWidth(context),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
            fontSize: 14,
            fontWeight: selTab ? FontWeight.w400 : FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
