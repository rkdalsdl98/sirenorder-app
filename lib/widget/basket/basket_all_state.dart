import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/basket/basket_bloc.dart';
import 'package:sirenorder_app/bloc/basket/event/clear_basket_event.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/basket/clear_basket_dialog.dart';

class BasketAllState extends StatelessWidget {
  const BasketAllState({
    super.key,
  });

  void showAllDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (builderContext) => const ClearBasketDialog(),
    ).then((value) {
      if (value != null && value is bool) {
        if (value) {
          context.read<BasketBloc>().add(ClearBasketEvent());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      width: double.maxFinite,
      height: 50 * getScaleHeight(context),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.1),
            width: 10,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => showAllDeleteDialog(context),
            child: Text(
              "전체삭제",
              style: TextStyles.defaultStyle.copyWith(
                fontSize: 12,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
