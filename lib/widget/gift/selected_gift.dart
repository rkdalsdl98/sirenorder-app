import 'package:flutter/material.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/gift/selected_gift_item.dart';

class SelectedGift extends StatelessWidget {
  final String menuname;
  int? price;
  String? thumbnail;
  SelectedGift({
    super.key,
    this.thumbnail,
    this.price,
    required this.menuname,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 200 * getScaleHeight(context),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 100 * getScaleWidth(context),
        height: 200 * getScaleHeight(context),
        child: SelectedGiftItem(
          menuname: menuname,
          price: price ?? 0,
          thumbnail: thumbnail,
        ),
      ),
    );
  }
}
