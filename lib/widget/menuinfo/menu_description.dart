import 'package:flutter/material.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/methods.dart';
import 'package:sirenorder_app/type/bloc/menu_type.dart';
import 'package:sirenorder_app/widget/menuinfo/select_tempture.dart';

class MenuDescription extends StatelessWidget {
  String? en_name;
  int? price;
  MenuDetailModel? detail;
  MenuCategory? category;
  MenuDescription({
    super.key,
    this.category,
    this.detail,
    this.en_name,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              en_name ?? "",
              style: TextStyles.defaultStyle.copyWith(
                fontSize: 13,
                color: Theme.of(context).colorScheme.outline.withOpacity(.8),
              ),
            ),
            SizedBox(height: 5 * getScaleHeight(context)),
            Text(
              detail?.description ?? "",
              style: TextStyles.defaultStyle.copyWith(
                fontSize: 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                addComma(price ?? 0),
                style: TextStyles.titleStyle,
              ),
            ),
            if (category == MenuCategory.drink) const SelectTempture(),
          ],
        ),
      ),
    );
  }
}
