import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/type/order_state.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';

class MenuItem extends StatelessWidget {
  final MenuModel menu;
  const MenuItem({
    super.key,
    required this.menu,
  });

  void onPaying(
    BuildContext context,
    OrderType type,
  ) {
    final bloc = context.read<UserBloc>();
    final user = bloc.state.user;

    if (user == null) {
      Navigator.pop(context);
      showSnackBarMessage(
        context,
        "데모버전은 로그인 이후에 이용해주세요.",
      );
      return;
    }

    switch (type) {
      case OrderType.order:
        showPaymentPage(context, user);
        break;
      case OrderType.gift:
        showGiftPage(context);
        break;
    }
  }

  void showGiftPage(BuildContext context) {
    int amount = 0 + (menu.price * menu.count);
    String type = "gift";

    Navigator.pushNamed(
      context,
      "/gift",
      arguments: {
        "menu": menu.toJson(),
        "amount": amount,
        "type": type,
      },
    );
    return;
  }

  void showPaymentPage(
    BuildContext context,
    UserModel user,
  ) {
    int amount = 0 + (menu.price * menu.count);
    String type = "order";

    final order = OrderModel(
      menu.name,
      user.tel!,
      user.email!,
      user.nickname!,
      PaymentCustomData.fromJson({
        "type": type,
        "data": {
          "storeId": "d2b4192e-a1a9-4e94-9ab4-1047ddaec2ed",
          "orderInfo": {
            "deliveryinfo": {
              "memo": "곧 가지러 감",
              "take": true,
              "paymenttype": "card",
            },
            "menus": [menu],
          },
        },
      }),
      amount,
    );

    Navigator.pushNamed(
      context,
      "/payment",
      arguments: {
        "order": order.toJson(),
        "type": type,
      },
    );
    return;
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (builderContext) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        content: SizedBox(
          width: double.maxFinite,
          height: 100 * getScaleHeight(builderContext),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                menu.name,
                textAlign: TextAlign.center,
                style: TextStyles.titleStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10 * getScaleHeight(context)),
              Text(
                "구매하실 상품이 맞는지 확인 해주세요!",
                textAlign: TextAlign.center,
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 10,
                  height: 1.8,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 80 * getScaleWidth(builderContext),
                    height: 30 * getScaleHeight(builderContext),
                    child: RoundedButtonSmall(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      text: "선물하기",
                      fontSize: 12,
                      onTab: () => onPaying(
                        builderContext,
                        OrderType.gift,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80 * getScaleWidth(builderContext),
                    height: 30 * getScaleHeight(builderContext),
                    child: RoundedButtonSmall(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      text: "주문하기",
                      fontSize: 12,
                      onTab: () => onPaying(
                        builderContext,
                        OrderType.order,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70 * getScaleWidth(builderContext),
                    height: 30 * getScaleHeight(builderContext),
                    child: RoundedButtonSmall(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      text: "아니요",
                      fontSize: 12,
                      onTab: () => Navigator.pop(context),
                    ),
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
    return InkWell(
      onTap: () {
        showAlertDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        height: 60 * getScaleHeight(context),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(menu.thumbnail),
                ),
                borderRadius: BorderRadius.circular(180),
                color: const Color(0xFFD9D9D9),
              ),
              width: 40 * getScaleWidth(context),
              height: 40 * getScaleHeight(context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    menu.name,
                    textAlign: TextAlign.left,
                    style: TextStyles.defaultStyle.copyWith(fontSize: 14),
                  ),
                  Text(
                    "카페인 음료",
                    textAlign: TextAlign.left,
                    style: TextStyles.defaultStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
