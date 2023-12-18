import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/menu/menu_bloc.dart';
import 'package:sirenorder_app/bloc/order/event/upsert_data_event.dart';
import 'package:sirenorder_app/bloc/order/order_bloc.dart';
import 'package:sirenorder_app/bloc/store/store_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/widget/common/input_form.dart';
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

  void onPaying() {
    final form = _formkey.currentState;
    if (form == null) {
      showSnackBarMessage(
        context,
        "시스템에 오류가 발생했습니다.\n페이지를 닫고, 주문을 다시 진행 해주세요.",
      );
      return;
    }
    form.save();

    OrderModel? order = createOrder();
  }

  OrderModel? createOrder() {
    return null;

    // 장바구니 목록 불러오기 루틴 추가 해야 됨
    // final orderBloc = context.read<OrderBloc>();
    // final data = orderBloc.state.data;
    // final deliveryInfo = DeliveryInfo.fromJson({
    //   ...data,
    //   "memo": result['memo'] ?? "",
    // });
    // final amount =
    //     context.read<MenuBloc>().state.detail!.price * widget.menu.count;
    // final user = context.read<UserBloc>().state.user!;
    // final storeId = context.read<StoreBloc>().state.selStore!.storeId;
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
              onPaying: onPaying,
            ),
          ],
        ),
      ),
    );
  }
}
