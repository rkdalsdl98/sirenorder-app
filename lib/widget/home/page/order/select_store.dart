import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/basket/basket_bloc.dart';
import 'package:sirenorder_app/bloc/store/event/select_store_event.dart';
import 'package:sirenorder_app/bloc/store/store_bloc.dart';
import 'package:sirenorder_app/bloc/store/store_bloc_state.dart';
import 'package:sirenorder_app/model/store_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class SelectStore extends StatelessWidget {
  bool showBasket;
  SelectStore({
    super.key,
    this.showBasket = true,
  });

  void selectStore(BuildContext context) {
    Navigator.pushNamed(context, '/store').then((json) {
      if (json != null) {
        final StoreModel store =
            StoreModel.fromJson(json as Map<String, dynamic>);
        context.read<StoreBloc>().add(SelectStoreEvent(store));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.maxFinite,
      height: 40 * getScaleHeight(context),
      child: BlocBuilder<StoreBloc, StoreBlocState>(
          builder: (builderContext, state) {
        final selectedStore = state.selStore;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedStore == null
                  ? "잠깐! 주문하기전 매장을 선택해주세요."
                  : "${selectedStore.storename} 매장에 주문합니다.",
              style: TextStyles.defaultStyle.copyWith(
                color: Theme.of(builderContext).colorScheme.background,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 20 * getScaleHeight(builderContext),
              child: RoundedButtonSmall(
                text: selectedStore == null ? "매장선택" : "매장바꾸기",
                onTab: () => selectStore(builderContext),
                backgroundColor:
                    Theme.of(builderContext).colorScheme.onSurfaceVariant,
                textColor: Theme.of(builderContext).colorScheme.background,
              ),
            ),
            if (showBasket)
              InkWell(
                onTap: () => Navigator.pushNamed(context, "/basket"),
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 30 * getScaleWidth(builderContext),
                  height: 30 * getScaleHeight(builderContext),
                  child: Stack(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 30 * getScaleWidth(builderContext),
                        color: Theme.of(builderContext).colorScheme.outline,
                      ),
                      Positioned(
                        left: 11 * getScaleWidth(builderContext),
                        top: 9 * getScaleHeight(builderContext),
                        child: Text(
                          "${context.watch<BasketBloc>().state.basket.length}",
                          style: TextStyles.titleStyle.copyWith(
                            fontSize: 14,
                            color:
                                Theme.of(builderContext).colorScheme.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
