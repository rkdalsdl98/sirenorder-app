import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/common/rounded_button_medium.dart';

class OtherService extends StatelessWidget {
  const OtherService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 100 * getScaleHeight(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(.25),
              offset: const Offset(0, 2),
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "로그인 하시면 서비스 이용이 가능합니다.",
                style: TextStyles.defaultStyle.copyWith(fontSize: 16),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 155 * getScaleWidth(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedButtonMedium(
                      text: "회원가입",
                      onTab: () => Navigator.pushNamed(
                        context,
                        "/login",
                        arguments: {"page": 1},
                      ),
                    ),
                    RoundedButtonMedium(
                      text: "로그인",
                      backgroundColor: Theme.of(context).colorScheme.background,
                      textColor: const Color(0xFF1CBA3E),
                      onTab: () => Navigator.pushNamed(
                        context,
                        "/login",
                        arguments: {"page": 0},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
