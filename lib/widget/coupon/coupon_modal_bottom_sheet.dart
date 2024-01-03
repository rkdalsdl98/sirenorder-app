import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/order/order_bloc.dart';
import 'package:sirenorder_app/bloc/store/store_bloc.dart';
import 'package:sirenorder_app/bloc/user/event/use_coupon_event.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/widget/common/input_form.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/widget/menuinfo/select_packaging_method.dart';
import 'package:sirenorder_app/widget/menuinfo/select_tempture.dart';

class CouponModalBottomSheet extends StatefulWidget {
  final CouponModel coupon;
  const CouponModalBottomSheet({
    super.key,
    required this.coupon,
  });

  @override
  State<CouponModalBottomSheet> createState() => _CouponModalBottomSheetState();
}

class _CouponModalBottomSheetState extends State<CouponModalBottomSheet> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Map<String, dynamic> result = {};

  void onUpdateResult(String key, dynamic data) => result[key] = data;
  void onSendOroder() {
    final store = context.read<StoreBloc>().state.selStore;
    if (store == null) {
      showSnackBarMessage(context, "주문하실 매장을 선택해주세요.");
      FocusScope.of(context).unfocus();
      Navigator.pop(context);
      return;
    }
    DeliveryInfo? deliveryinfo = createDeliveryInfo();
    if (deliveryinfo == null) {
      return;
    }

    final userBloc = context.read<UserBloc>();
    userBloc.add(UseCouponEvent(
      widget.coupon,
      deliveryinfo,
      store.storeId,
    ));
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  DeliveryInfo? createDeliveryInfo() {
    final data = context.read<OrderBloc>().state.data;
    if (data.keys.length < 2) {
      showSnackBarMessage(context, "선택하지 않은 항목이 있습니다.");
      Navigator.pop(context);
      return null;
    }
    return DeliveryInfo(
      result['memo'] ?? "",
      "coupon",
      data['take'],
      data['packagingMethod'],
      data['tempture'] ?? "HOT",
      "Tall",
    );
  }

  @override
  Widget build(BuildContext context) {
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
                widget.coupon.menu_name,
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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: SelectPackagingMethod(),
                    ),
                    const SelectTempture(),
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
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: 300 * getScaleWidth(context),
              height: 40 * getScaleHeight(context),
              child: RoundedButtonSmall(
                text: "주문하기",
                onTab: onSendOroder,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
