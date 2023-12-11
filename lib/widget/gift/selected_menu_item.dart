import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class SelectedMenuItem extends StatelessWidget {
  bool isLoading;
  SelectedMenuItem({
    super.key,
    this.isLoading = false,
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(
                  "assets/img/hot_americano.png",
                ),
                fit: BoxFit.cover,
                opacity: isLoading ? .25 : 1,
              ),
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "아메리카노\n",
              style: TextStyles.titleStyle.copyWith(
                fontSize: 20,
                height: 1.6,
              ),
              children: const [
                TextSpan(
                  text: "가격: 2,000 원\n",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextSpan(
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
