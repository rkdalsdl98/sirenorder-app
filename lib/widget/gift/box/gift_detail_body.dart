import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/widget/gift/box/gift_guide_texts.dart';
import 'package:sirenorder_app/widget/gift/box/gift_info.dart';
import 'package:sirenorder_app/widget/gift/box/message_card.dart';

class GiftDetailBody extends StatelessWidget {
  final GiftModel gift;
  const GiftDetailBody({
    super.key,
    required this.gift,
  });
  Future<void> copyCode(BuildContext context, String str) async {
    await Clipboard.setData(ClipboardData(text: str)).then((_) {
      showSnackBarMessage(context, "쿠폰코드 복사 했습니다.");
      return;
    }).catchError((err) {
      showSnackBarMessage(context, "쿠폰코드 복사를 실패했습니다.");
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 200 * getScaleWidth(context),
              height: 200 * getScaleHeight(context),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                    color: Theme.of(context).colorScheme.shadow.withOpacity(.2),
                  )
                ],
              ),
              child: gift.coupon!.thumbnail == null
                  ? Text(
                      "미리보기 이미지가 없는 메뉴입니다.",
                      style: TextStyles.defaultStyle.copyWith(
                        fontSize: 18,
                      ),
                    )
                  : Image.network(
                      gift.coupon!.thumbnail!,
                      fit: BoxFit.cover,
                    ),
            ),
            MessageCard(wrappingtype: gift.wrappingtype),
            Text(
              gift.message!,
              style: TextStyles.defaultStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.lightGreen[700],
              ),
            ),
            // 쿠폰, 보낸이, 메뉴
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 6,
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(.1),
                  ),
                ),
              ),
              width: double.maxFinite,
              height: 120 * getScaleHeight(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${gift.from}님이 보낸 선물",
                    style: TextStyles.defaultStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    gift.coupon!.menu_name,
                    style: TextStyles.defaultStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "쿠폰번호",
                    style: TextStyles.defaultStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        gift.coupon!.code,
                        style: TextStyles.defaultStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: () => copyCode(context, gift.coupon!.code),
                        child: Icon(
                          Icons.copy,
                          size: 18,
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withOpacity(.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GiftInfo(gift: gift),
            const GuideTexts()
          ],
        ),
      ),
    );
  }
}
