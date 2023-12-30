import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/type/order_state.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class OrderOrGiftDialog extends StatelessWidget {
  final String menuname;
  final Function(BuildContext, OrderType) onPaying;

  const OrderOrGiftDialog({
    super.key,
    required this.menuname,
    required this.onPaying,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      content: SizedBox(
        width: double.maxFinite,
        height: 100 * getScaleHeight(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              menuname,
              textAlign: TextAlign.center,
              style: TextStyles.titleStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10 * getScaleHeight(context)),
            Text(
              "구매하실 상품이 맞는지 확인 해주세요!",
              textAlign: TextAlign.center,
              style: TextStyles.defaultStyle.copyWith(
                fontSize: 10,
                height: 1.8,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80 * getScaleWidth(context),
                  height: 30 * getScaleHeight(context),
                  child: RoundedButtonSmall(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    text: "선물하기",
                    fontSize: 12,
                    onTab: () => onPaying(
                      context,
                      OrderType.gift,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80 * getScaleWidth(context),
                  height: 30 * getScaleHeight(context),
                  child: RoundedButtonSmall(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    text: "주문하기",
                    fontSize: 12,
                    onTab: () => onPaying(
                      context,
                      OrderType.order,
                    ),
                  ),
                ),
                SizedBox(
                  width: 70 * getScaleWidth(context),
                  height: 30 * getScaleHeight(context),
                  child: RoundedButtonSmall(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    text: "아니요",
                    fontSize: 12,
                    onTab: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
