import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/methods.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/type/order_state.dart';
import 'package:sirenorder_app/widget/bill/bill_detail_dialog.dart';
import 'package:sirenorder_app/widget/common/square_rounded_button.dart';
import 'package:intl/intl.dart';

class BillItem extends StatelessWidget {
  final OrderHistory history;
  const BillItem({
    super.key,
    required this.history,
  });

  void showDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (builderContext) => BillDetailDialog(
        deliveryinfos: history.deliveryinfos ?? [],
        menus: history.menus ?? [],
        totalprice: history.totalprice ?? 0,
        storeName: history.storeName ?? "",
        orderedAt: history.orderedAt ?? "",
      ),
    );
  }

  void onReOrder(BuildContext context, String orderName) {
    final OrderModel? order = createOrder(context, orderName);
    if (order == null) {
      return;
    }

    Navigator.pushNamed(
      context,
      "/payment",
      arguments: {
        "order": order.toJson(),
        "type": "order",
      },
    );
  }

  OrderModel? createOrder(BuildContext context, String orderName) {
    if (history.deliveryinfos!.isEmpty ||
        history.menus!.isEmpty ||
        history.storeId == null) {
      showSnackBarMessage(context, "주문정보를 불러 올 수 없어 요청이 취소되었습니다.");
      return null;
    }
    final amount =
        history.menus?.fold<int>(0, (prev, menu) => prev += menu.price ?? 0);
    final user = context.read<UserBloc>().state.user!;
    final customData = PaymentCustomData.fromJson({
      "type": "order",
      "data": {
        "storeId": history.storeId,
        "orderInfo": {
          "deliveryinfo": [...history.deliveryinfos!],
          "menus": [...history.menus!],
        },
      },
    });
    print(amount);
    return OrderModel.fromJson({
      "name": orderName,
      "buyer_tel": user.tel!,
      "buyer_email": user.email!,
      "buyer_name": user.nickname!,
      "custom_data": customData.toJson(),
      "amount": amount,
    });
  }

  @override
  Widget build(BuildContext context) {
    MenuModel? firstMenu = history.menus![0];
    DeliveryInfo? firstInfo = history.deliveryinfos?[0];
    String historyName = history.menus!.length > 1
        ? "${firstMenu.name ?? ""} 외 ${history.menus!.length - 1}개의 메뉴"
        : firstMenu.name ?? "";
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.2),
            width: 6,
          ),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                history.orderedAt == null
                    ? "날짜 조회실패"
                    : DateFormat("yyyy년 MM월 dd일")
                        .format(DateTime.parse(history.orderedAt!)),
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.outline.withOpacity(.6),
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 120 * getScaleWidth(context),
                height: 120 * getScaleHeight(context),
                decoration: history.menus?[0].thumbnail != null
                    ? BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            history.menus![0].thumbnail,
                          ),
                          fit: BoxFit.cover,
                        ),
                      )
                    : null,
                child: history.menus?[0].thumbnail == null
                    ? Center(
                        child: Text(
                        "미리보기 이미지가 없는 메뉴입니다.",
                        style: TextStyles.defaultStyle.copyWith(
                          fontSize: 18,
                        ),
                      ))
                    : null,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(right: 10),
                width: 200 * getScaleWidth(context),
                height: 100 * getScaleHeight(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "$historyName\n",
                        style: TextStyles.titleStyle.copyWith(
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: firstMenu.en_name ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(.8),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${firstInfo?.tempture ?? ""} | ${firstInfo?.size ?? ""} | ${firstInfo?.packagingMethod ?? ""}",
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 12,
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(.8),
                          ),
                        ),
                        Text(
                          "${addComma(history.totalprice ?? 0)}원",
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SquareRoundedButton(
                  text: "주문상세",
                  width: 80,
                  height: 30,
                  onTab: () => showDetail(context),
                  fontWeight: FontWeight.w500,
                  backgroundColor:
                      Theme.of(context).colorScheme.outline.withOpacity(.2),
                ),
                SizedBox(width: 10 * getScaleWidth(context)),
                SquareRoundedButton(
                  text: "같은 매장에서 재 주문하기",
                  width: 200,
                  height: 30,
                  onTab: () => onReOrder(context, historyName),
                  fontWeight: FontWeight.w500,
                  backgroundColor:
                      Theme.of(context).colorScheme.outline.withOpacity(.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
