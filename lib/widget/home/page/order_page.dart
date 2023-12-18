import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/menu/event/get_menu_list_event.dart';
import 'package:sirenorder_app/bloc/menu/menu_bloc.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/common/loading_indicator.dart';
import 'package:sirenorder_app/widget/home/page/order/order_page_body.dart';
import 'package:sirenorder_app/widget/home/page/order/select_store.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    final bloc = context.read<MenuBloc>();
    bloc.add(GetMenuListEvent(null));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 타이틀
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Order",
                  style: TextStyles.titleStyle,
                ),
              ),
              const OrderPageBody(),
              // 매장선택
              SelectStore(),
            ],
          ),
        ),
        if (isLoading) const LoadingIndicator(),
      ],
    );
  }
}
