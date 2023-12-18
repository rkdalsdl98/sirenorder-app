import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class SelectSizeButton extends StatelessWidget {
  final int index;
  final int selectIndex;
  final String size;
  final String volume;
  final void Function(String, int) onSelectSize;
  const SelectSizeButton({
    super.key,
    required this.index,
    required this.selectIndex,
    required this.size,
    required this.volume,
    required this.onSelectSize,
  });

  @override
  Widget build(BuildContext context) {
    Color deactiveColor = Theme.of(context).colorScheme.outline.withOpacity(.8);
    String activeIcon = "assets/img/select_bottle_size_icon.png";
    String deactiveIcon = "assets/img/unselect_bottle_size_icon.png";
    return InkWell(
      radius: 0,
      highlightColor: Colors.transparent,
      onTap: () => onSelectSize(size, index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 10),
        width: 75 * getScaleWidth(context),
        height: 100 * getScaleHeight(context),
        decoration: BoxDecoration(
          border: Border.all(
            width: selectIndex >= 0 ? (selectIndex == index ? 2 : 1) : 1,
            color: selectIndex >= 0
                ? (selectIndex == index
                    ? const Color(0xFF1CBA3E)
                    : deactiveColor)
                : deactiveColor,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              selectIndex >= 0
                  ? (selectIndex == index ? activeIcon : deactiveIcon)
                  : deactiveIcon,
              width: (25 + (5 * index)) * getScaleWidth(context),
              height: (25 + (5 * index)) * getScaleHeight(context),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "$size\n",
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: volume,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
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
