import 'package:flutter/material.dart';
import 'package:sirenorder_app/model/basket_item_model.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/type/check_state.dart';
import 'package:sirenorder_app/widget/basket/basket_all_state.dart';
import 'package:sirenorder_app/widget/basket/basket_item.dart';
import 'package:sirenorder_app/widget/basket/basket_view_bottom_sheet.dart';

class BasketViewBody extends StatefulWidget {
  final List<BasketItemModel> basket;
  const BasketViewBody({
    super.key,
    required this.basket,
  });

  @override
  State<BasketViewBody> createState() => _BasketViewBodyState();
}

class _BasketViewBodyState extends State<BasketViewBody> {
  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 30),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "주문메뉴",
                      style: TextStyles.titleStyle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const BasketAllState(),
                  ...widget.basket.map<BasketItem>((item) {
                    return BasketItem(
                      item: item,
                      index: index++,
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
        BasketViewBottomSheet(basket: widget.basket)
      ],
    );
  }
}
