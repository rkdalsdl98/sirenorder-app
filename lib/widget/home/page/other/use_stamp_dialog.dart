import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class UseStampDialog extends StatelessWidget {
  const UseStampDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 80),
      content: SizedBox(
        width: double.maxFinite,
        height: 70 * getScaleHeight(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "스탬프 교환",
              textAlign: TextAlign.center,
              style: TextStyles.titleStyle.copyWith(
                fontSize: 16,
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
                    text: "교환하기",
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
                    text: "닫기",
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
