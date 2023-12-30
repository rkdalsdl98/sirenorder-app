import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/basket/basket_bloc.dart';
import 'package:sirenorder_app/bloc/basket/basket_bloc_state.dart';
import 'package:sirenorder_app/bloc/basket/event/showed_error_event.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/widget/basket/basket_view_body.dart';
import 'package:sirenorder_app/widget/common/loading_indicator.dart';
import 'package:sirenorder_app/widget/common/rounded_button_medium.dart';
import 'package:sirenorder_app/widget/home/page/order/select_store.dart';

class Basket extends StatelessWidget {
  const Basket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            color: Colors.black87,
            width: double.maxFinite,
            height: 100 * getScaleHeight(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: 25 * getScaleWidth(context),
                        height: 25 * getScaleHeight(context),
                        child: Text(
                          "<",
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 22,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "장바구니",
                      style: TextStyles.defaultStyle.copyWith(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                SelectStore(showBasket: false),
              ],
            ),
          ),
          BlocBuilder<BasketBloc, BasketBlocState>(
              builder: (blocContext, state) {
            final basket = state.basket;
            if (state is BasketBlocErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showSnackBarMessage(context, state.exception.message);
                Future.delayed(const Duration(milliseconds: 1)).then((_) =>
                    blocContext.read<BasketBloc>().add(ShowedErrorEvent()));
              });
            } else if (state is BasketBlocSuccessedActionState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(const Duration(milliseconds: 1)).then((_) =>
                    blocContext.read<BasketBloc>().add(ShowedErrorEvent()));
              });
            }
            return Expanded(
              child: Stack(
                children: [
                  basket.isNotEmpty
                      ? BasketViewBody(basket: basket)
                      : emptyHelper(context),
                  if (state is BasketBlocLoadingState) const LoadingIndicator(),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

Widget emptyHelper(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
    child: SizedBox(
      width: double.maxFinite,
      height: 130 * getScaleHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "음료/푸드 장바구니가\n비어있습니다.",
            style: TextStyles.titleStyle.copyWith(
              fontSize: 20,
            ),
          ),
          Text(
            "원하는 메뉴를 장바구니 담고\n한번에 주문해 보세요.",
            style: TextStyles.defaultStyle.copyWith(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(.8),
            ),
          ),
          SizedBox(
            width: 110 * getScaleWidth(context),
            child: RoundedButtonMedium(
              text: "메뉴 담으러 가기",
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              onTab: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    ),
  );
}
