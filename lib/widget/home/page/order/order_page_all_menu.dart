import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/menu/menu_bloc.dart';
import 'package:sirenorder_app/bloc/menu/menu_state.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/type/bloc/menu_type.dart';
import 'package:sirenorder_app/widget/home/page/order/menu_item.dart';
import 'package:sirenorder_app/widget/home/page/order/order_category.tabs.dart';

class OrderAllMenu extends StatefulWidget {
  const OrderAllMenu({
    super.key,
  });

  @override
  State<OrderAllMenu> createState() => _OrderAllMenuState();
}

class _OrderAllMenuState extends State<OrderAllMenu> {
  int currIndex = 0;
  bool isLoading = false;
  void onChangeTab(int index) => setState(() {
        currIndex = index;
      });
  Map<MenuCategory, List<MenuModel>> sortMenuList(
    List<MenuModel> list,
  ) {
    final Map<MenuCategory, List<MenuModel>> sortedMap = {};
    for (var item in list) {
      sortedMap.update(
        item.category,
        (prevList) {
          prevList.add(item);
          return prevList;
        },
        ifAbsent: () => [item],
      );
    }
    return sortedMap;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 435 * getScaleHeight(context),
      child: Column(
        children: [
          OrderCategoryTabs(
            currIndex: currIndex,
            onChangeTab: onChangeTab,
          ),
          BlocBuilder<MenuBloc, MenuBlocState>(builder: (_, state) {
            if (state is MenuBlocLoadingState) {
              isLoading = true;
            } else {
              if (isLoading && state is MenuBlocErrorState) {
                final exception = state.exception;
                showSnackBarMessage(
                  context,
                  exception.message,
                );
              }
              isLoading = false;
            }
            final sortedMap = sortMenuList(state.menus);
            return Expanded(
              child: SingleChildScrollView(
                child: IndexedStack(
                  index: currIndex,
                  children: [
                    menuListhelper(
                      context,
                      sortedMap[MenuCategory.drink] ?? [],
                    ),
                    menuListhelper(
                      context,
                      sortedMap[MenuCategory.food] ?? [],
                    ),
                    menuListhelper(
                      context,
                      sortedMap[MenuCategory.product] ?? [],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

Widget menuListhelper(
  BuildContext context,
  List<MenuModel> list,
) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Column(
      children: list
          .map<MenuItem>(
            (item) => MenuItem(menu: item),
          )
          .toList(),
    ),
  );
}
