import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/basket/basket_bloc.dart';
import 'package:sirenorder_app/bloc/basket/event/put_menu_event.dart';
import 'package:sirenorder_app/bloc/order/event/upsert_data_event.dart';
import 'package:sirenorder_app/bloc/order/order_bloc.dart';
import 'package:sirenorder_app/bloc/store/store_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/model/basket_item_model.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/methods.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/type/order_state.dart';
import 'package:sirenorder_app/widget/common/input_form.dart';
import 'package:sirenorder_app/widget/common/square_rounded_button.dart';
import 'package:sirenorder_app/widget/menuinfo/alert_stars_over_message.dart';
import 'package:sirenorder_app/widget/menuinfo/select_packaging_method.dart';
import 'package:sirenorder_app/widget/menuinfo/select_size.dart';
import 'package:sirenorder_app/widget/menuinfo/send_order_modal_bottom_nav.dart';

class SendOrderModalBottomSheet extends StatefulWidget {
  final Map<String, String> sizes;
  final MenuModel menu;
  const SendOrderModalBottomSheet({
    super.key,
    required this.sizes,
    required this.menu,
  });

  @override
  State<SendOrderModalBottomSheet> createState() =>
      _SendOrderModalBottomSheetState();
}

class _SendOrderModalBottomSheetState extends State<SendOrderModalBottomSheet> {
  int selectSizeIndex = -1;
  bool usePoint = false;
  bool isShowError = false;
  String selectSize = "Short";
  Map<String, dynamic> result = {};
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  void onSelectSize(String size, int index) => setState(() {
        selectSize = size;
        selectSizeIndex = index;
        context.read<OrderBloc>().add(UpsertDataEvent("size", selectSize));
      });
  void incrementCount() => setState(() {
        ++widget.menu.count;
      });
  void decrementCount() => setState(() {
        --widget.menu.count;
      });
  void onUpdateResult(String key, dynamic data) => result[key] = data;

  void onPaying(int point) async {
    final form = _formkey.currentState;
    if (form == null) {
      showSnackBarMessage(
        context,
        "시스템에 오류가 발생했습니다.\n페이지를 닫고, 주문을 다시 진행 해주세요.",
      );
      return;
    }
    form.save();
    final stars = context.read<UserBloc>().state.user!.wallet!.stars!;
    if (stars >= 3) {
      final allow = await allowOverIncreaseStamp();
      if (allow == null || !allow) {
        return;
      }
    }

    OrderModel? order = createOrder(point);
    if (order == null) {
      return;
    }
    navPushNamed(
      route: "/payment",
      arguments: {
        "order": order.toJson(),
        "type": "order",
      },
    );
    return;
  }

  navPushNamed({
    required String route,
    Object? arguments,
  }) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  void onPutMenu() {
    final basket = context.read<BasketBloc>().state.basket;
    if (basket.length >= 20) {
      showSnackBarMessage(context, "장바구니엔 최대 20가지 메뉴를 담을 수 있습니다.");
      return;
    }
    final form = _formkey.currentState;
    if (form == null) {
      showSnackBarMessage(
        context,
        "시스템에 오류가 발생했습니다.\n페이지를 닫고, 주문을 다시 진행 해주세요.",
      );
      return;
    }

    form.save();
    BasketItemModel? item = createBasketItem();
    if (item == null) {
      return;
    }
    context.read<BasketBloc>().add(PutMenuEvent(item));
  }

  Future<bool?> allowOverIncreaseStamp() async {
    return await showDialog<bool?>(
      context: context,
      builder: (builderContext) => const AlertStarsOverMessage(),
    ).then((value) {
      if (value == null) {
        return value;
      }
      Navigator.pop(context);
      return value;
    });
  }

  DeliveryInfo? createDeliveryInfo() {
    final data = context.read<OrderBloc>().state.data;
    if (data.keys.length < 3) {
      showSnackBarMessage(context, "선택하지 않은 항목이 있습니다.");
      Navigator.pop(context);
      return null;
    }
    return DeliveryInfo(
      result['memo'] ?? "",
      "card",
      data['take'],
      data['packagingMethod'],
      data['tempture'] ?? "HOT",
      data['size'],
    );
  }

  BasketItemModel? createBasketItem() {
    final deliveryInfo = createDeliveryInfo();
    if (deliveryInfo == null) {
      return null;
    }
    BasketItemModel item = BasketItemModel(
      deliveryInfo,
      widget.menu,
    );
    return item;
  }

  OrderModel? createOrder(int point) {
    final deliveryInfo = createDeliveryInfo();
    if (deliveryInfo == null) {
      return null;
    }
    final amount = widget.menu.price * widget.menu.count;
    final user = context.read<UserBloc>().state.user!;
    final storeId = context.read<StoreBloc>().state.selStore!.storeId;
    final customData = PaymentCustomData.fromJson({
      "type": "order",
      "data": {
        "storeId": storeId,
        "orderInfo": {
          "deliveryinfo": [deliveryInfo],
          "menus": [widget.menu],
          "point": point,
        },
      },
    });

    return OrderModel.fromJson({
      "name": widget.menu.name,
      "buyer_tel": user.tel!,
      "buyer_email": user.email!,
      "buyer_name": user.nickname!,
      "custom_data": customData.toJson(),
      "amount": amount,
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserBloc>().state.user!;
    return InkWell(
      radius: 0,
      highlightColor: Colors.transparent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        width: double.maxFinite,
        height: 600 * getScaleHeight(context),
        child: Column(
          children: [
            Container(
              width: 60 * getScaleWidth(context),
              height: 5,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline,
                borderRadius: BorderRadius.circular(45),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                widget.menu.name,
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      width: double.maxFinite,
                      height: 30 * getScaleHeight(context),
                      decoration: BoxDecoration(
                        color: const Color(0xFF99FFCC).withOpacity(.3),
                      ),
                      child: Center(
                        child: Text(
                          "환경을 위해 일회용컵 사용 줄이기에 동참해 주세요.",
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 0, 134, 29),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "사용가능한 포인트  ",
                              style:
                                  TextStyles.titleStyle.copyWith(fontSize: 12),
                              children: [
                                TextSpan(
                                  text: "${addComma(user.wallet!.point!)} P",
                                  style: const TextStyle(
                                      color: Color(0xFF1CBA3E), fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SquareRoundedButton(
                              text: "모두사용",
                              onTab: () => setState(() {
                                usePoint = !usePoint;
                              }),
                              width: 60,
                              height: 20,
                              fontSize: 10,
                              backgroundColor: const Color(0xFF1CBA3E),
                              fontColor:
                                  Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SelectSize(
                      selectSizeIndex: selectSizeIndex,
                      onSelectSize: onSelectSize,
                      sizes: widget.sizes,
                    ),
                    const SelectPackagingMethod()
                  ],
                ),
              ),
            ),
            InputForm(
              formKey: _formkey,
              fields: const {
                "memo": {
                  "hint": "매장에 남길 메모가 있다면 여기에 입력해주세요.",
                  "max_length": 20,
                }
              },
              onUpdateResult: onUpdateResult,
            ),
            SendOrderModalBottomNav(
              incrementCount: incrementCount,
              decrementCount: decrementCount,
              count: widget.menu.count,
              usePoint: usePoint,
              onPaying: onPaying,
              onPutMenu: onPutMenu,
              price: widget.menu.price,
            ),
          ],
        ),
      ),
    );
  }
}
