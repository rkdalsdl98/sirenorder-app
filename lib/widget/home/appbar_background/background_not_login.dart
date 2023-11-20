import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class BackgrounNotLogin extends StatelessWidget {
  const BackgrounNotLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 17),
          width: 130 * getScaleWidth(context),
          height: 110 * getScaleHeight(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "사이렌 오더 회원이\n되시면 다양한 혜택을\n받을 수 있어요!",
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  height: 1.5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 60 * getScaleWidth(context),
                    height: 20 * getScaleHeight(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(180),
                      color: const Color(0xFF1CBA3E),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "회원가입",
                        textAlign: TextAlign.center,
                        style: TextStyles.defaultStyle.copyWith(
                          color: Theme.of(context).colorScheme.background,
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 60 * getScaleWidth(context),
                    height: 20 * getScaleHeight(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(180),
                      color: Theme.of(context).colorScheme.background,
                      border: Border.all(
                        color: const Color(0xFF1CBA3E),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "로그인",
                        textAlign: TextAlign.center,
                        style: TextStyles.defaultStyle.copyWith(
                          color: const Color(0xFF1CBA3E),
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Image(
            image: const AssetImage("assets/img/hot_americano.png"),
            width: 100 * getScaleWidth(context),
            height: 100 * getScaleHeight(context),
          ),
        ),
      ],
    );
  }
}
