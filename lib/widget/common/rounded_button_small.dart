import 'package:flutter/material.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class RoundedButtonSmall extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  void Function()? onTab;
  bool disabled;
  bool isLoading;
  double? fontSize;

  RoundedButtonSmall({
    super.key,
    required this.text,
    this.backgroundColor = const Color(0xFF1CBA3E),
    this.textColor = const Color(0xFFFEFBFF),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    this.onTab,
    this.fontSize,
    this.disabled = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : (disabled ? null : onTab),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(180),
          border: Border.all(
            color: isLoading
                ? Colors.grey
                : (disabled ? const Color(0xFFD9D9D9) : textColor),
          ),
          color: isLoading
              ? Colors.black12
              : (disabled ? const Color(0xFFD9D9D9) : backgroundColor),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyles.defaultStyle.copyWith(
              color: isLoading
                  ? Colors.grey
                  : (disabled ? const Color(0xFFFEFBFF) : textColor),
              fontSize: fontSize ?? 8,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
