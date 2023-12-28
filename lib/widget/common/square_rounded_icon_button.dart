import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class SquareRoundedIconButton extends StatelessWidget {
  final String text;
  final IconData icondata;
  final double iconSize;
  double height;
  void Function()? onTab;
  double? fontSize;

  SquareRoundedIconButton({
    super.key,
    required this.text,
    required this.icondata,
    required this.iconSize,
    this.height = 20,
    this.onTab,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(.25),
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      width: 140 * getScaleWidth(context),
      height: 140 * getScaleHeight(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height * getScaleHeight(context)),
          Icon(
            icondata,
            color: const Color(0xFF1CBA3E),
            size: iconSize * getScaleWidth(context),
          ),
          SizedBox(height: 5 * getScaleHeight(context)),
          Text(
            text,
            style: TextStyles.titleStyle.copyWith(fontSize: fontSize ?? 18),
          ),
        ],
      ),
    );
  }
}
