import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/methods.dart';

class SelectedGiftItem extends StatelessWidget {
  final String menuname;
  final int price;
  String? thumbnail;
  SelectedGiftItem({
    super.key,
    this.thumbnail,
    required this.menuname,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100 * getScaleWidth(context),
      height: 180 * getScaleHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100 * getScaleWidth(context),
            height: 100 * getScaleHeight(context),
            decoration: thumbnail == null
                ? null
                : BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        thumbnail!,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
            child: thumbnail == null
                ? Text(
                    "미리보기 이미지가 없는 메뉴입니다.",
                    style: TextStyles.defaultStyle.copyWith(
                      fontSize: 18,
                    ),
                  )
                : null,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "$menuname\n",
              style: TextStyles.titleStyle.copyWith(
                fontSize: 20,
                height: 1.6,
              ),
              children: [
                TextSpan(
                  text: "가격: ${addComma(price)} 원\n",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const TextSpan(
                  text: "수량: 1 개",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
