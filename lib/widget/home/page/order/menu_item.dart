import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/menu/event/clear_menu_detail_event.dart';
import 'package:sirenorder_app/bloc/menu/menu_bloc.dart';
import 'package:sirenorder_app/bloc/store/store_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/type/order_state.dart';
import 'package:sirenorder_app/widget/home/page/order/order_or_gift_dialog.dart';

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
    final user = context.read<UserBloc>().state.user;

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
        showMenuInfoPage(context, user);
        break;
      case OrderType.gift:
        showGiftPage(context);
        break;
    }
  }

  void showGiftPage(BuildContext context) {
    int amount = 0;
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

  void showMenuInfoPage(
    BuildContext context,
    UserModel user,
  ) {
    final selectedStore = context.read<StoreBloc>().state.selStore;

    if (selectedStore == null) {
      Navigator.pop(context);
      showSnackBarMessage(
        context,
        "주문을 요청할 가게를 선택해주세요.",
      );
      return;
    }
    int amount = 0;
    String type = "order";

    Navigator.pushNamed(
      context,
      "/menu-info",
      arguments: {
        "menu": menu.toJson(),
        "amount": amount,
        "type": type,
      },
    ).whenComplete(() => context.read<MenuBloc>().add(ClearMenuDetailEvent()));
    return;

    // final order = OrderModel(
    //   menu.name,
    //   user.tel!,
    //   user.email!,
    //   user.nickname!,
    //   PaymentCustomData.fromJson({
    //     "type": type,
    //     "data": {
    //       "storeId": "d2b4192e-a1a9-4e94-9ab4-1047ddaec2ed",
    //       "orderInfo": {
    //         "deliveryinfo": {
    //           "memo": "곧 가지러 감",
    //           "take": true,
    //           "paymenttype": "card",
    //         },
    //         "menus": [menu],
    //       },
    //     },
    //   }),
    //   amount,
    // );

    // Navigator.pushNamed(
    //   context,
    //   "/payment",
    //   arguments: {
    //     "order": order.toJson(),
    //     "type": type,
    //   },
    // );
    // return;
  }

  void showAlertDialog(
    BuildContext context, {
    required String menuname,
    required Function(
      BuildContext context,
      OrderType type,
    ) onPaying,
  }) {
    showDialog(
      context: context,
      builder: (builderContext) => OrderOrGiftDialog(
        menuname: menuname,
        onPaying: onPaying,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showAlertDialog(
        context,
        menuname: menu.name,
        onPaying: onPaying,
      ),
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
