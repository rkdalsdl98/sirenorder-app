import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class SquareRoundedButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  void Function()? onTab;
  double? fontSize;
  Color? fontColor;
  Color? backgroundColor;
  FontWeight? fontWeight;

  SquareRoundedButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    this.onTab,
    this.fontSize = 12,
    this.backgroundColor = Colors.blueGrey,
    this.fontColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius:
              BorderRadius.circular((15 / width) * (30 - (15 / width))),
        ),
        width: width * getScaleWidth(context),
        height: height * getScaleHeight(context),
        child: Center(
          child: Text(
            text,
            style: TextStyles.titleStyle.copyWith(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: fontColor,
            ),
          ),
        ),
      ),
    );
  }
}
