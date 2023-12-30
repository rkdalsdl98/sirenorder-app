import 'package:flutter/material.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/widget/gift/box/gift_box_item.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class GiftList extends StatelessWidget {
  final List<GiftModel> gifts;
  final bool isUsedList;
  const GiftList({
    super.key,
    required this.gifts,
    required this.isUsedList,
  });

  @override
  Widget build(BuildContext context) {
    return gifts.isNotEmpty
        ? GridView.count(
            padding: const EdgeInsets.all(10),
            crossAxisCount: 2,
            children: gifts
                .map<GiftBoxItem>(
                  (gift) => GiftBoxItem(gift: gift),
                )
                .toList(),
          )
        : Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUsedList ? "선물을 사용한\n기록이 없습니다" : "사용 가능한\n선물이 없습니다",
                  style: TextStyles.titleStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 180 * getScaleHeight(context)),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          "${isUsedList ? "선물을 받은 기록이 없어요!" : "선물함이 비어 있어요."}\n",
                      style: TextStyles.defaultStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: "마음을 주고받으며 선물함을 채워보세요!",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
