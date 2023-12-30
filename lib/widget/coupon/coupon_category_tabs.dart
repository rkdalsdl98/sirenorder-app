import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class CouponCategoryTabs extends StatelessWidget {
  final void Function(int page) onTabCategory;
  final double width;
  final double pageOffset;
  const CouponCategoryTabs({
    super.key,
    required this.onTabCategory,
    required this.width,
    required this.pageOffset,
  });

  @override
  Widget build(BuildContext context) {
    int index = -1;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(.4),
          ),
        ),
      ),
      width: double.maxFinite,
      child: Stack(
        children: [
          Row(
            children: ["쿠폰사용", "쿠폰등록"].map<Widget>((category) {
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
            }).toList(),
          ),
          Positioned(
            bottom: 0,
            left: ((width * getScaleWidth(context)) * pageOffset),
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
