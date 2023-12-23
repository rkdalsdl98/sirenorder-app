import 'package:flutter/material.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class GiftBoxItem extends StatelessWidget {
  final GiftModel gift;
  const GiftBoxItem({
    super.key,
    required this.gift,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/gift-detail', arguments: {
        "gift": gift.toJson(),
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 140 * getScaleWidth(context),
                height: 120 * getScaleHeight(context),
                decoration: BoxDecoration(
                  image: gift.coupon!.thumbnail != null
                      ? DecorationImage(
                          image: NetworkImage(
                            gift.coupon!.thumbnail!,
                          ),
                          fit: BoxFit.contain,
                        )
                      : null,
                ),
                child: gift.coupon!.thumbnail == null
                    ? Text(
                        "미리보기 이미지가 없는 메뉴입니다.",
                        style: TextStyles.defaultStyle.copyWith(
                          fontSize: 18,
                        ),
                      )
                    : null,
              ),
            ),
            Text(
              gift.coupon!.menu_name,
              style: TextStyles.defaultStyle.copyWith(
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              "from. ${gift.from ?? ""}",
              style: TextStyles.defaultStyle.copyWith(
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
