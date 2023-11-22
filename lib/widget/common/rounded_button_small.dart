import 'package:flutter/material.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class RoundedButtonSmall extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  void Function()? onTab;
  double? fontSize;

  RoundedButtonSmall({
    super.key,
    required this.text,
    this.backgroundColor = const Color(0xFF1CBA3E),
    this.textColor = const Color(0xFFFEFBFF),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    this.onTab,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(180),
          border: Border.all(color: textColor),
          color: backgroundColor,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyles.defaultStyle.copyWith(
              color: textColor,
              fontSize: fontSize ?? 8,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
