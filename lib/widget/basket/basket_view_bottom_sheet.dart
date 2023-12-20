import 'package:flutter/material.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/model/basket_item_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/system/methods.dart';
import 'package:sirenorder_app/widget/common/rounded_button_medium.dart';

class BasketViewBottomSheet extends StatefulWidget {
  final List<BasketItemModel> basket;
  const BasketViewBottomSheet({
    super.key,
    required this.basket,
  });

  @override
  State<BasketViewBottomSheet> createState() => _BasketViewBottomSheetState();
}

class _BasketViewBottomSheetState extends State<BasketViewBottomSheet> {
  int amount = 0;

  void calAmount() {
    amount = 0;
    for (var item in widget.basket) {
      amount += (item.price * item.menu.count);
    }
  }

  @override
  void initState() {
    super.initState();
    calAmount();
  }

  @override
  void didUpdateWidget(_) {
    super.didUpdateWidget(_);
    calAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.maxFinite,
      height: 100 * getScaleHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "총 ",
                  style: TextStyles.defaultStyle.copyWith(
                    color: const Color(0xFF6c3c0c),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: "${widget.basket.length}",
                      style: const TextStyle(
                        color: Color(0xFF1CBA3E),
                      ),
                    ),
                    const TextSpan(text: "개 / 20개"),
                  ],
                ),
              ),
              Text(
                "${addComma(amount)}원",
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          RoundedButtonMedium(
            text: "주문하기",
            fontSize: 14,
            onTab: () {},
          ),
        ],
      ),
    );
  }
}
