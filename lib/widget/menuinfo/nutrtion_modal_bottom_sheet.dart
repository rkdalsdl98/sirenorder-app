import 'package:flutter/material.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/menuinfo/nutrition_info.dart';
import 'package:sirenorder_app/widget/menuinfo/nutritions_category_tabs.dart';

class NutritionModalBottomSheet extends StatefulWidget {
  final List<NutritionsModel> data;
  const NutritionModalBottomSheet({
    super.key,
    required this.data,
  });

  @override
  State<NutritionModalBottomSheet> createState() =>
      _NutritionModalBottomSheetState();
}

class _NutritionModalBottomSheetState extends State<NutritionModalBottomSheet> {
  final PageController _controller = PageController();
  final double categoryWidth = 80;
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
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: double.maxFinite,
      height: 600 * getScaleHeight(context),
      child: Column(
        children: [
          Container(
            width: 60 * getScaleWidth(context),
            height: 5,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(45),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              "제품 영양 정보",
              style: TextStyles.titleStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          NutritionCategoryTabs(
            onTabCategory: onTabCategory,
            width: categoryWidth,
            pageOffset: pageOffset,
            categorys: widget.data.map<String>((n) => n.size).toList(),
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              children: widget.data
                  .map<Widget>(
                    (nutrition) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            "용량 ${nutrition.volume}",
                            style: TextStyles.defaultStyle.copyWith(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(.8),
                            ),
                          ),
                        ),
                        NutritionInfo(data: nutrition.toJson()),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
