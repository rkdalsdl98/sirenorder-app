import 'package:flutter/material.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/gift/box/gift_detail_body.dart';

class GiftDetail extends StatelessWidget {
  final Map<String, dynamic> data;
  const GiftDetail({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final GiftModel gift = GiftModel.fromJson(data);
    return Scaffold(
      body: Column(
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
                  "선물상세",
                  style: TextStyles.defaultStyle.copyWith(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          GiftDetailBody(gift: gift),
        ],
      ),
    );
  }
}
