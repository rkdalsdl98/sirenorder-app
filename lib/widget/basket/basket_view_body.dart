import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/type/check_state.dart';
import 'package:sirenorder_app/widget/basket/basket_all_state.dart';

class BasketViewBody extends StatefulWidget {
  const BasketViewBody({
    super.key,
  });

  @override
  State<BasketViewBody> createState() => _BasketViewBodyState();
}

class _BasketViewBodyState extends State<BasketViewBody> {
  final OneCheckState allState = OneCheckState("전체 선택");

  void onChangeState(bool state) => setState(() {
        allState.state = state;
      });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              BasketAllState(
                allState: allState,
                onChangeState: onChangeState,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
