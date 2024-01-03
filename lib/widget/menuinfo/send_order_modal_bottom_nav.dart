import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/basket/basket_bloc.dart';
import 'package:sirenorder_app/bloc/basket/basket_bloc_state.dart';
import 'package:sirenorder_app/bloc/basket/event/showed_error_event.dart';
import 'package:sirenorder_app/bloc/menu/menu_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/methods.dart';
import 'package:sirenorder_app/widget/common/counter.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';

class SendOrderModalBottomNav extends StatefulWidget {
  final void Function() incrementCount;
  final void Function() decrementCount;
  final void Function(int point) onPaying;
  final void Function() onPutMenu;
  final int count;
  final int price;
  final bool usePoint;
  const SendOrderModalBottomNav({
    super.key,
    required this.decrementCount,
    required this.incrementCount,
    required this.count,
    required this.price,
    required this.onPaying,
    required this.onPutMenu,
    required this.usePoint,
  });

  @override
  State<SendOrderModalBottomNav> createState() =>
      _SendOrderModalBottomNavState();
}

class _SendOrderModalBottomNavState extends State<SendOrderModalBottomNav> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<UserBloc>().state.user!;
    final int price = widget.count * widget.price;
    final int point = widget.usePoint
        ? (price < user.wallet!.point! ? price : user.wallet!.point!)
        : 0;
    return BlocBuilder<BasketBloc, BasketBlocState>(
        builder: (blocContext, state) {
      if (state is BasketBlocErrorState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          blocContext.read<BasketBloc>().add(ShowedErrorEvent());
          Future.delayed(const Duration(milliseconds: 1))
              .then((_) => Navigator.pop(blocContext, state.exception));
        });
      } else if (state is BasketBlocSuccessedActionState) {
        blocContext.read<BasketBloc>().add(ShowedErrorEvent());
        Future.delayed(const Duration(milliseconds: 1))
            .then((_) => Navigator.pop(blocContext, true));
      }
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(blocContext).colorScheme.background,
          border: Border(
            top: BorderSide(
              color: Theme.of(blocContext).colorScheme.outline.withOpacity(.2),
            ),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 6),
              color: Theme.of(blocContext).shadowColor.withOpacity(.1),
              blurRadius: 10,
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        height: 100 * getScaleHeight(blocContext),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Counter(
                  count: widget.count,
                  decrementCount: widget.decrementCount,
                  incrementCount: widget.incrementCount,
                ),
                Text(
                  "${addComma(price - point)}원",
                  style: TextStyles.titleStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RoundedButtonSmall(
                  text: "담기",
                  onTab: widget.onPutMenu,
                  fontSize: 14,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  backgroundColor: Theme.of(blocContext).colorScheme.background,
                  textColor: const Color(0xFF1CBA3E),
                ),
                SizedBox(width: 10 * getScaleWidth(blocContext)),
                RoundedButtonSmall(
                  text: "주문하기",
                  onTab: () => widget.onPaying(point),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                  fontSize: 14,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
