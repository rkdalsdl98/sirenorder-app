import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';

class MenuItem extends StatelessWidget {
  final MenuModel menu;
  const MenuItem({
    super.key,
    required this.menu,
  });

  void showPaymentPage(BuildContext context) {
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

    final order = OrderModel(
      menu.name,
      {
        "memo": "곧 가지러 감",
        "take": true,
        "paymenttype": "card",
      },
      user.tel!,
      user.email!,
      user.nickname!,
      [menu],
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      "/payment",
      (route) => false,
      arguments: {"order": order.toJson()},
    );
    return;
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (builderContext) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 80),
        content: SizedBox(
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
                      text: "확인",
                      fontSize: 12,
                      onTab: () => showPaymentPage(builderContext),
                    ),
                  ),
                  SizedBox(
                    width: 80 * getScaleWidth(builderContext),
                    height: 30 * getScaleHeight(builderContext),
                    child: RoundedButtonSmall(
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
