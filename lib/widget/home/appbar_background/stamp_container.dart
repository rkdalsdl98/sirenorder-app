import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class StampContainer extends StatelessWidget {
  const StampContainer({
    super.key,
    required this.stampSize,
  });

  final double stampSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 15),
      width: 180 * getScaleWidth(context),
      height: 120 * getScaleHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "내 스탬프",
                style: TextStyles.titleStyle.copyWith(fontSize: 14),
              ),
              Text(
                "6개를 모으면 아메리카노 한잔이 무료에요!",
                style: TextStyles.defaultStyle.copyWith(fontSize: 8),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/stamp_deactive.png",
                    width: stampSize * getScaleWidth(context),
                    height: stampSize * getScaleHeight(context),
                  ),
                  Image.asset(
                    "assets/img/stamp_deactive.png",
                    width: stampSize * getScaleWidth(context),
                    height: stampSize * getScaleHeight(context),
                  ),
                  Image.asset(
                    "assets/img/stamp_deactive.png",
                    width: stampSize * getScaleWidth(context),
                    height: stampSize * getScaleHeight(context),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img/stamp_deactive.png",
                    width: stampSize * getScaleWidth(context),
                    height: stampSize * getScaleHeight(context),
                  ),
                  Image.asset(
                    "assets/img/stamp_deactive.png",
                    width: stampSize * getScaleWidth(context),
                    height: stampSize * getScaleHeight(context),
                  ),
                  Image.asset(
                    "assets/img/stamp_deactive.png",
                    width: stampSize * getScaleWidth(context),
                    height: stampSize * getScaleHeight(context),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
