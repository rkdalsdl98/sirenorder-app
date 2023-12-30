import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/common/rounded_button_medium.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class RemoveBasketItemDialog extends StatelessWidget {
  const RemoveBasketItemDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: const EdgeInsets.only(top: 15),
        width: 200 * getScaleWidth(context),
        height: 100 * getScaleHeight(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "선택 하신 메뉴를\n삭제하시겠어요?",
              style: TextStyles.defaultStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RoundedButtonMedium(
                  text: "아니요",
                  backgroundColor: Theme.of(context).colorScheme.background,
                  textColor: const Color(0xFF1CBA3E),
                  onTab: () => Navigator.pop(context),
                ),
                SizedBox(width: 10 * getScaleWidth(context)),
                RoundedButtonMedium(
                  text: "삭제",
                  onTab: () => Navigator.pop(context, true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
