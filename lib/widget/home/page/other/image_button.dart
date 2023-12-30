import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class ImageButton extends StatelessWidget {
  final String text;
  final String imageUrl;
  void Function()? onTab;

  ImageButton({
    super.key,
    required this.text,
    required this.imageUrl,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imageUrl,
          width: 50 * getScaleWidth(context),
          height: 50 * getScaleHeight(context),
        ),
        Text(
          text,
          style: TextStyles.defaultStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
