import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class Finders extends StatelessWidget {
  final void Function(int index) onChangePage;
  const Finders({
    super.key,
    required this.onChangePage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      width: double.maxFinite,
      height: 20 * getScaleHeight(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {},
            child: SizedBox(
              width: 70 * getScaleWidth(context),
              height: double.maxFinite,
              child: Text(
                "아이디 찾기",
                textAlign: TextAlign.center,
                style: TextStyles.defaultStyle.copyWith(fontSize: 12),
              ),
            ),
          ),
          Container(
            height: 10 * getScaleHeight(context),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: SizedBox(
              width: 70 * getScaleWidth(context),
              height: double.maxFinite,
              child: Text(
                "비밀번호 찾기",
                textAlign: TextAlign.center,
                style: TextStyles.defaultStyle.copyWith(fontSize: 12),
              ),
            ),
          ),
          Container(
            height: 10 * getScaleHeight(context),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              onChangePage(1);
            },
            child: SizedBox(
              width: 70 * getScaleWidth(context),
              height: double.maxFinite,
              child: Text(
                "회원가입",
                textAlign: TextAlign.center,
                style: TextStyles.defaultStyle.copyWith(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
