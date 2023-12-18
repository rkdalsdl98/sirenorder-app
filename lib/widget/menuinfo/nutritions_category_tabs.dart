import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class NutritionCategoryTabs extends StatelessWidget {
  final void Function(int page) onTabCategory;
  final double width;
  final double pageOffset;
  final List<String> categorys;
  const NutritionCategoryTabs({
    super.key,
    required this.onTabCategory,
    required this.width,
    required this.pageOffset,
    required this.categorys,
  });

  @override
  Widget build(BuildContext context) {
    int index = -1;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.4),
          ),
        ),
      ),
      child: Stack(
        children: [
          Row(
            children: categorys.map<Widget>(
              (category) {
                ++index;
                int page = index;
                return InkWell(
                  onTap: () => onTabCategory(page),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: width * getScaleWidth(context),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyles.defaultStyle.copyWith(
                          fontSize: 14,
                          fontWeight: pageOffset.floor() == index
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
          Positioned(
            bottom: 0,
            left: (width * getScaleWidth(context) * pageOffset),
            child: Container(
              width: width * getScaleWidth(context),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF1CBA3E),
                    width: 4,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
