import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';

class OrderMyMenu extends StatelessWidget {
  const OrderMyMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(10),
      width: double.maxFinite,
      height: 400 * getScaleHeight(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 100 * getScaleHeight(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "나만의 메뉴 서비스는 로그인 후에\n이용하실 수 있습니다.",
                  style: TextStyles.titleStyle.copyWith(fontSize: 20),
                ),
                SizedBox(
                  width: 130 * getScaleWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundedButtonSmall(text: "회원가입"),
                      RoundedButtonSmall(
                        text: "로그인",
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        textColor: const Color(0xFF1CBA3E),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40 * getScaleHeight(context)),
          Image.asset(
            "assets/img/stamp.png",
            width: 200 * getScaleWidth(context),
            height: 200 * getScaleHeight(context),
          ),
        ],
      ),
    );
  }
}
