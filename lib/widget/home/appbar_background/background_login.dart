import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/widget/home/appbar_background/stamp_container.dart';

class BackgroundLogin extends StatelessWidget {
  BackgroundLogin({super.key});
  double stampSize = 50;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StampContainer(stampSize: stampSize),
        Container(
          margin: const EdgeInsets.only(right: 10, top: 15),
          width: 160 * getScaleWidth(context),
          height: 120 * getScaleHeight(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "교환하기 버튼을 통해 모아온\n스탬프를 쿠폰으로 교환 할 수 있습니다.\n",
                    textAlign: TextAlign.center,
                    style: TextStyles.defaultStyle.copyWith(
                      fontSize: 6,
                    ),
                  ),
                  Text(
                    "교환된 쿠폰은 하단에 Other 탭\n혹은 쿠폰함 버튼을 통해\n확인 하실 수 있습니다.",
                    textAlign: TextAlign.center,
                    style: TextStyles.defaultStyle.copyWith(
                      fontSize: 6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 60 * getScaleWidth(context),
                height: 100 * getScaleHeight(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedButtonSmall(
                      onTab: () {},
                      text: "쿠\n폰\n함",
                      fontSize: 10,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      textColor: const Color(0xFF1CBA3E),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                    ),
                    RoundedButtonSmall(
                      onTab: () {},
                      text: "교\n환\n하\n기",
                      fontSize: 10,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      textColor: const Color(0xFF1CBA3E),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
