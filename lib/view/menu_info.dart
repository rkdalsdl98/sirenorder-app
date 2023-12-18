import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/menu/event/get_menu_detail_event.dart';
import 'package:sirenorder_app/bloc/menu/menu_bloc.dart';
import 'package:sirenorder_app/bloc/menu/menu_state.dart';
import 'package:sirenorder_app/bloc/order/event/clear_data_event.dart';
import 'package:sirenorder_app/bloc/order/order_bloc.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/common/loading_indicator.dart';
import 'package:sirenorder_app/widget/menuinfo/menu_description.dart';
import 'package:sirenorder_app/widget/menuinfo/menu_info_app_bar.dart';
import 'package:sirenorder_app/widget/menuinfo/nutritions.dart';
import 'package:sirenorder_app/widget/menuinfo/send_order.dart';

class MenuInfo extends StatefulWidget {
  final Map<String, dynamic> json;
  final String type;
  const MenuInfo({
    super.key,
    required this.json,
    required this.type,
  });

  @override
  State<MenuInfo> createState() => _MenuInfoState();
}

class _MenuInfoState extends State<MenuInfo> {
  late final MenuModel menu;
  final ScrollController _scrollController = ScrollController();
  final double _toolbarHeight = 40;
  final double _expandedHeight = 300;
  final Map<String, String> sizes = {};
  bool isPinned = false;
  bool isLoading = true;
  bool isInitilzed = false;

  @override
  void initState() {
    super.initState();
    menu = MenuModel.fromJson(widget.json);
    _scrollController.addListener(() {
      if (_scrollController.offset >
          ((_expandedHeight * getScaleHeight(context)) * .88)) {
        setState(() {
          isPinned = true;
        });
      } else {
        setState(() {
          isPinned = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MenuBloc, MenuBlocState>(
          builder: (builderContext, state) {
        if (state.detail == null && !isInitilzed) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isInitilzed = true;
            builderContext
                .read<MenuBloc>()
                .add(GetMenuDetailEvent(menu.detailId));
          });
        }
        if (state is! MenuBlocLoadingState) {
          if (state.detail != null && isLoading) {
            state.detail?.nutritions.forEach((json) {
              final nutrition = NutritionsModel.fromJson(json);
              sizes[nutrition.size] = nutrition.volume;
            });
          }
          isLoading = false;
        } else {
          isLoading = true;
        }
        return Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 580 * getScaleHeight(context),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      MenuInfoAppBar(
                        toolbarHeight: _toolbarHeight,
                        expandedHeight: _expandedHeight,
                        isPinned: isPinned,
                        menuname: menu.name,
                        thumbnail: menu.thumbnail,
                      ),
                      // 상품 설명
                      MenuDescription(
                        category: menu.category,
                        en_name: menu.en_name,
                        detail: state.detail,
                      ),
                      // 상품 영양 표
                      Nutritions(
                        data: state.detail?.nutritions
                                .map<NutritionsModel>(
                                    (n) => NutritionsModel.fromJson(n))
                                .toList() ??
                            [],
                      ),
                      allergyHelper(
                        builderContext,
                        allergys: state.detail?.allergys
                            .map((allergy) => allergy.toString())
                            .toList(),
                      ),
                    ],
                  ),
                ),
                SendOrder(
                  sizes: sizes,
                  menu: menu,
                ),
              ],
            ),
            if (isLoading) const LoadingIndicator()
          ],
        );
      }),
    );
  }
}

Widget allergyHelper(
  BuildContext context, {
  List<String>? allergys,
}) {
  allergys = allergys ?? [];
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: RichText(
        text: TextSpan(
          text: "알레르기 유발 요인\n",
          style: TextStyles.titleStyle.copyWith(
            fontSize: 14,
            height: 1.5,
          ),
          children: allergys
              .map<TextSpan>(
                (allergy) => TextSpan(
                  text: " $allergy ",
                  style: TextStyles.titleStyle.copyWith(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.8),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
