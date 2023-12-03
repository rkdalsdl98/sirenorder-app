import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/menu/event/get_menu_list_event.dart';
import 'package:sirenorder_app/bloc/menu/menu_bloc.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/common/loading_indicator.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/widget/home/page/order/order_page_body.dart';

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
        if (isLoading) const LoadingIndicator(),
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
              Container(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.maxFinite,
                height: 40 * getScaleHeight(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "잠깐! 주문하기전 매장을 선택해주세요.",
                      style: TextStyles.defaultStyle.copyWith(
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 20 * getScaleHeight(context),
                      child: RoundedButtonSmall(
                        text: "매장선택",
                        backgroundColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                        textColor: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    SizedBox(width: 10 * getScaleWidth(context)),
                    Stack(
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          color: Theme.of(context).colorScheme.outline,
                          size: 28 * getScaleHeight(context),
                        ),
                        Positioned(
                          left: 10 * getScaleWidth(context),
                          top: 10 * getScaleHeight(context),
                          child: Text(
                            "0",
                            style: TextStyles.defaultStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
