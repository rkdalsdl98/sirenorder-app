import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class AlertStarsOverMessage extends StatelessWidget {
  const AlertStarsOverMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 70),
      content: SizedBox(
        width: double.maxFinite,
        height: 90 * getScaleHeight(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "현재 사용 할 수 있는 스탬프가 있습니다\n스탬프를 사용하지 않고 주문하게될 경우,\n이후에 적립되는 스탬프는 사라집니다",
              textAlign: TextAlign.center,
              style: TextStyles.titleStyle.copyWith(
                fontSize: 12,
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
                    text: "주문하기",
                    fontSize: 12,
                    onTab: () => Navigator.pop(context, true),
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
                    backgroundColor: Theme.of(context).colorScheme.background,
                    textColor: const Color(0xFF1CBA3E),
                    text: "취소",
                    fontSize: 12,
                    onTab: () => Navigator.pop(context, false),
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
