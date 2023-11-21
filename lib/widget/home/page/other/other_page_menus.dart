import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/common/square_rounded_button.dart';

class OtherPageMenus extends StatelessWidget {
  const OtherPageMenus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 10),
      width: double.maxFinite,
      height: 300 * getScaleHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SquareRoundedButton(
                text: "스탬프 내역",
                icondata: Icons.star_border_outlined,
                iconSize: 50,
              ),
              SquareRoundedButton(
                text: "개인정보 관리",
                icondata: Icons.lock_outline,
                iconSize: 45,
                height: 25,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SquareRoundedButton(
                text: "나만의 메뉴",
                icondata: Icons.local_drink,
                iconSize: 50,
              ),
              SquareRoundedButton(
                text: "계정정보",
                icondata: Icons.person_pin,
                iconSize: 45,
                height: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
