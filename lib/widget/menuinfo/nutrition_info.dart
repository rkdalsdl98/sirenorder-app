import 'package:flutter/material.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class NutritionInfo extends StatelessWidget {
  final Map<String, dynamic> data;
  const NutritionInfo({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    int index = -1;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        children: nutritionCategorys.map<Widget>(
          (key) {
            ++index;
            return Container(
              width: double.maxFinite,
              height: 40 * getScaleHeight(context),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(.4),
                  ),
                ),
              ),
              child: nutritionWrapHelper(
                type: nutritionKRCategorys[index],
                nutrition: data[key],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

Widget nutritionWrapHelper({
  required String type,
  required String nutrition,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        type,
        style: TextStyles.defaultStyle.copyWith(
          fontSize: 14,
        ),
      ),
      Text(
        nutrition,
        style: TextStyles.titleStyle.copyWith(
          fontSize: 14,
        ),
      ),
    ],
  );
}
