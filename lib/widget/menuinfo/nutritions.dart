import 'package:flutter/material.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/menuinfo/nutrtion_modal_bottom_sheet.dart';

class Nutritions extends StatelessWidget {
  final List<NutritionsModel>? data;
  const Nutritions({
    super.key,
    this.data,
  });

  void showNutritions(BuildContext context, List<NutritionsModel> data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builderContext) => NutritionModalBottomSheet(data: data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: () => showNutritions(context, data!),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(.4),
              ),
              top: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(.4),
              ),
            ),
          ),
          width: double.maxFinite,
          height: 50 * getScaleHeight(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "제품 영양 정보",
                style: TextStyles.titleStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              Text(
                ">",
                style: TextStyles.titleStyle.copyWith(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.outline.withOpacity(.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
