import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class OrderCategoryTab extends StatelessWidget {
  final String text;
  final bool selCategory;
  final void Function(int index) onChangeTab;

  const OrderCategoryTab({
    super.key,
    required this.text,
    required this.selCategory,
    required this.onChangeTab,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60 * getScaleWidth(context),
      height: 30 * getScaleHeight(context),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyles.defaultStyle.copyWith(
            fontSize: 12,
            color: selCategory
                ? Theme.of(context).colorScheme.onBackground
                : Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
    );
  }
}
