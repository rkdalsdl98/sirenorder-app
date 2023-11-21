import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print("Tab menu!"),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        height: 60 * getScaleHeight(context),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(180),
                color: const Color(0xFFD9D9D9),
              ),
              width: 40 * getScaleWidth(context),
              height: 40 * getScaleHeight(context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "카페인 음료",
                    textAlign: TextAlign.left,
                    style: TextStyles.defaultStyle.copyWith(fontSize: 14),
                  ),
                  Text(
                    "카페인 음료",
                    textAlign: TextAlign.left,
                    style: TextStyles.defaultStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
