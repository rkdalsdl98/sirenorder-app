import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/type/check_state.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/common/rounded_button_medium.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';

class BasketAllState extends StatelessWidget {
  final OneCheckState allState;
  final void Function(bool) onChangeState;

  const BasketAllState({
    super.key,
    required this.allState,
    required this.onChangeState,
  });

  void showAllDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (builderContext) => AlertDialog(
        content: Container(
          padding: const EdgeInsets.only(top: 15),
          width: 200 * getScaleWidth(context),
          height: 100 * getScaleHeight(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "장바구니에 담긴 모든 메뉴를\n삭제하시겠어요?",
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RoundedButtonMedium(
                    text: "아니요",
                    backgroundColor: Theme.of(context).colorScheme.background,
                    textColor: const Color(0xFF1CBA3E),
                    onTab: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 10 * getScaleWidth(context)),
                  RoundedButtonMedium(
                    text: "전체 삭제",
                    onTab: () => Navigator.pop(context, true),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(right: 15),
      width: double.maxFinite,
      height: 50 * getScaleHeight(context),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.1),
            width: 10,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: allState.state,
                activeColor: const Color(0xFF1CBA3E),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                onChanged: (value) => onChangeState(value!),
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color(0xFF1CBA3E);
                  }
                  return Theme.of(context).colorScheme.background;
                }),
              ),
              Text(
                "전체 선택",
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 12,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.8),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () => showAllDeleteDialog(context),
            child: Text(
              "전체삭제",
              style: TextStyles.defaultStyle.copyWith(
                fontSize: 12,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
