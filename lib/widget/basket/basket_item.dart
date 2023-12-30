import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/basket/basket_bloc.dart';
import 'package:sirenorder_app/bloc/basket/event/remove_menu_event.dart';
import 'package:sirenorder_app/bloc/basket/event/update_item_event.dart';
import 'package:sirenorder_app/model/basket_item_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/basket/basket_item_info.dart';
import 'package:sirenorder_app/widget/basket/remove_basket_item_dialog.dart';

class BasketItem extends StatefulWidget {
  final BasketItemModel item;
  final int index;
  const BasketItem({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  State<BasketItem> createState() => _BasketItemState();
}

class _BasketItemState extends State<BasketItem> {
  void incrementCount() {
    final basketBloc = context.read<BasketBloc>();
    ++widget.item.menu.count;
    basketBloc.add(UpdateItemEvent(widget.item, widget.index));
  }

  void decrementCount() {
    final basketBloc = context.read<BasketBloc>();
    --widget.item.menu.count;
    basketBloc.add(UpdateItemEvent(widget.item, widget.index));
  }

  void showRemoveItemDialog() {
    showDialog(
      context: context,
      builder: (builderContext) => const RemoveBasketItemDialog(),
    ).then((value) {
      if (value != null && value is bool) {
        if (value) {
          context.read<BasketBloc>().add(RemoveMenuEvent(widget.index));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 180 * getScaleHeight(context),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.4),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: showRemoveItemDialog,
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 18 * getScaleWidth(context),
                height: 18 * getScaleHeight(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(360),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(.8),
                  ),
                ),
                child: Center(
                    child: Text(
                  "X",
                  style: TextStyles.defaultStyle.copyWith(
                    fontSize: 12,
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(.8),
                  ),
                )),
              ),
            ),
          ),
          BasketItemInfo(
            info: widget.item.deliveryInfo,
            menu: widget.item.menu,
            price: widget.item.price,
            incrementCount: incrementCount,
            decrementCount: decrementCount,
          ),
        ],
      ),
    );
  }
}
