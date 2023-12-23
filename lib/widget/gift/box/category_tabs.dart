import 'package:flutter/material.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/dimenssion.dart';

class GiftBoxCategoryTabs extends StatelessWidget {
  final double pageOffset;
  final int usedGiftLength;
  final int notUsedGiftLength;
  final void Function(int) onTabCategory;
  GiftBoxCategoryTabs(
      {super.key,
      required this.pageOffset,
      required this.onTabCategory,
      required this.usedGiftLength,
      required this.notUsedGiftLength});

  double width = 60;
  TextStyle activeStyle = TextStyles.defaultStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  TextStyle deActiveStyle = TextStyles.defaultStyle.copyWith(
    fontSize: 12,
    color: const Color(0xFF75777F).withOpacity(.8),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.maxFinite,
      height: 30 * getScaleHeight(context),
      child: Stack(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => onTabCategory(0),
                child: SizedBox(
                  width: width * getScaleWidth(context),
                  child: Center(
                    child: Text(
                      "사용가능 $notUsedGiftLength",
                      style:
                          pageOffset.floor() < 1 ? activeStyle : deActiveStyle,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => onTabCategory(1),
                child: SizedBox(
                  width: width * getScaleWidth(context),
                  child: Center(
                    child: Text(
                      "사용완료 $usedGiftLength",
                      style:
                          pageOffset.floor() >= 1 ? activeStyle : deActiveStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: ((width * getScaleWidth(context)) * pageOffset),
            child: Container(
              width: width * getScaleWidth(context),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF1CBA3E),
                    width: 4,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
