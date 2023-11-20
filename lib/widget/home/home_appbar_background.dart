import 'package:flutter/material.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/home/appbar_background/background_not_login.dart';

class HomeAppBarBackground extends StatelessWidget {
  const HomeAppBarBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 40, bottom: 10),
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FittedBox(
            fit: BoxFit.cover,
            child: Text(
              "안녕하세요!\n반갑습니다!",
              style: TextStyles.titleStyle,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 55),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    color:
                        Theme.of(context).colorScheme.shadow.withOpacity(.25))
              ],
            ),
            width: double.maxFinite,
            height: 150 * getScaleHeight(context),
            child: const BackgrounNotLogin(),
          ),
        ],
      ),
    );
  }
}