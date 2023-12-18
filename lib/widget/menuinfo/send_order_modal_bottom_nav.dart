import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/menu/menu_bloc.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/methods.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';

class SendOrderModalBottomNav extends StatelessWidget {
  final void Function() incrementCount;
  final void Function() decrementCount;
  final void Function() onPaying;
  final int count;
  const SendOrderModalBottomNav({
    super.key,
    required this.decrementCount,
    required this.incrementCount,
    required this.count,
    required this.onPaying,
  });

  @override
  Widget build(BuildContext context) {
    final int price = context.read<MenuBloc>().state.detail?.price ?? 0;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.2),
          ),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            color: Theme.of(context).shadowColor.withOpacity(.1),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      width: double.maxFinite,
      height: 100 * getScaleHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 100 * getScaleWidth(context),
                    height: 30 * getScaleHeight(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: count > 1 ? () => decrementCount() : null,
                          child: SizedBox(
                            width: 24 * getScaleWidth(context),
                            height: 24 * getScaleHeight(context),
                            child: Image.asset(
                              count > 1
                                  ? "assets/img/minus_active.png"
                                  : "assets/img/minus_deactive.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          "$count",
                          style: TextStyles.titleStyle.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () => incrementCount(),
                          child: SizedBox(
                            width: 24 * getScaleWidth(context),
                            height: 24 * getScaleHeight(context),
                            child: Image.asset(
                              "assets/img/plus.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "${addComma(count * price)}원",
                style: TextStyles.titleStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RoundedButtonSmall(
                text: "담기",
                onTab: () {},
                fontSize: 14,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                backgroundColor: Theme.of(context).colorScheme.background,
                textColor: const Color(0xFF1CBA3E),
              ),
              SizedBox(width: 10 * getScaleWidth(context)),
              RoundedButtonSmall(
                text: "주문하기",
                onTab: onPaying,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                fontSize: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
