import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/gift/box/category_tabs.dart';
import 'package:sirenorder_app/widget/gift/box/gift_list.dart';

class GiftBox extends StatefulWidget {
  const GiftBox({super.key});

  @override
  State<GiftBox> createState() => _GiftBoxState();
}

class _GiftBoxState extends State<GiftBox> {
  final PageController _controller = PageController();
  double pageOffset = 0;

  void onTabCategory(int index) {
    setState(() {
      _controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    });
  }

  bool isExpired(DateTime date) {
    final now = DateTime.now();
    return now.compareTo(date) > 0;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        pageOffset = _controller.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserBlocState>(
        builder: (blocContext, state) {
          final gifts = state.user!.gifts ?? [];
          final List<GiftModel> usedGifts = [];
          final List<GiftModel> notUsedGifts = gifts.where((g) {
            if (g.used! || isExpired(g.coupon!.expirationPeriod)) {
              usedGifts.add(g);
              return false;
            }
            return true;
          }).toList();
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    color: Colors.black87,
                    width: double.maxFinite,
                    height: 60 * getScaleHeight(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            width: 25 * getScaleWidth(context),
                            height: 25 * getScaleHeight(context),
                            child: Text(
                              "<",
                              style: TextStyles.defaultStyle.copyWith(
                                fontSize: 22,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "선물함",
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  GiftBoxCategoryTabs(
                    onTabCategory: onTabCategory,
                    pageOffset: pageOffset,
                    usedGiftLength: usedGifts.length,
                    notUsedGiftLength: notUsedGifts.length,
                  ),
                  Expanded(
                    child: PageView(
                      controller: _controller,
                      children: [
                        GiftList(
                          gifts: notUsedGifts,
                          isUsedList: false,
                        ),
                        GiftList(
                          gifts: usedGifts,
                          isUsedList: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
