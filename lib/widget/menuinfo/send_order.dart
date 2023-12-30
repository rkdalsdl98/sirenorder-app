import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/order/event/clear_data_event.dart';
import 'package:sirenorder_app/bloc/order/order_bloc.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/widget/menuinfo/send_order_modal_bottom_sheet.dart';

class SendOrder extends StatelessWidget {
  final Map<String, String> sizes;
  final MenuModel menu;
  const SendOrder({
    super.key,
    required this.sizes,
    required this.menu,
  });

  void showOrderModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builderContext) => SendOrderModalBottomSheet(
        sizes: sizes,
        menu: menu,
      ),
    ).then((value) {
      if (value is BlocException) {
        showSnackBarMessage(context, value.message);
      } else if (value is bool) {
        showSnackBarMessage(context, "장바구니에 메뉴를 담았습니다.");
      }
      context.read<OrderBloc>().add(ClearDataEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.4),
          ),
        ),
      ),
      width: double.maxFinite,
      height: 60 * getScaleHeight(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        width: double.maxFinite,
        height: 60 * getScaleHeight(context),
        child: RoundedButtonSmall(
          text: "주문하기",
          fontSize: 14,
          onTab: () => showOrderModal(context),
        ),
      ),
    );
  }
}
