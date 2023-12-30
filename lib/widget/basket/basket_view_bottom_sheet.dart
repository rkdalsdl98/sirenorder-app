import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/menu/menu_bloc.dart';
import 'package:sirenorder_app/bloc/order/order_bloc.dart';
import 'package:sirenorder_app/bloc/store/store_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/model/basket_item_model.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/system/methods.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/type/order_state.dart';
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

  void onPaying() {
    final user = context.read<UserBloc>().state.user;
    if (user == null) {
      showSnackBarMessage(
        context,
        "로그인 이후에 주문이 가능합니다.",
      );
      return;
    }

    final OrderModel? order = createOrder();
    if (order == null) {
      return;
    }
    Navigator.pop(context);
    Navigator.pushNamed(
      context,
      "/payment",
      arguments: {
        "order": order.toJson(),
        "type": "order",
      },
    );
    return;
  }

  List<DeliveryInfo> createDeliveryInfos() {
    return widget.basket.map((b) => b.deliveryInfo).toList();
  }

  OrderModel? createOrder() {
    final deliveryInfos = createDeliveryInfos();
    final amount = widget.basket
        .fold<int>(0, (prev, item) => prev += item.price * item.menu.count);
    final user = context.read<UserBloc>().state.user!;
    final store = context.read<StoreBloc>().state.selStore;
    if (store == null) {
      showSnackBarMessage(
        context,
        "주문을 요청할 가게를 선택해주세요.",
      );
      return null;
    }
    final customData = PaymentCustomData.fromJson({
      "type": "order",
      "data": {
        "storeId": store.storeId,
        "orderInfo": {
          "deliveryinfo": deliveryInfos,
          "menus": widget.basket.map((e) => e.menu).toList(),
        },
      },
    });
    final menuname = widget.basket.length > 1
        ? "${widget.basket[0].menu.name}외 ${widget.basket.length - 1}건"
        : widget.basket[0].menu.name;

    return OrderModel.fromJson({
      "name": menuname,
      "buyer_tel": user.tel!,
      "buyer_email": user.email!,
      "buyer_name": user.nickname!,
      "custom_data": customData.toJson(),
      "amount": amount,
    });
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
            onTab: onPaying,
          ),
        ],
      ),
    );
  }
}
