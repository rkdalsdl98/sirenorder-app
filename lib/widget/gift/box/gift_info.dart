import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/model/user_model.dart';

class GiftInfo extends StatelessWidget {
  final GiftModel gift;
  const GiftInfo({
    super.key,
    required this.gift,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 6,
            color: Theme.of(context).colorScheme.outline.withOpacity(.1),
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            "선물정보",
            style: TextStyles.defaultStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          giftInfoHelper(
            context,
            category: "유효기간",
            text: DateFormat("yyyy년 MM월 dd일")
                .format(gift.coupon!.expirationPeriod),
          ),
          giftInfoHelper(
            context,
            category: "쿠폰상태",
            text: gift.used! ? "사용완료" : "사용가능",
          ),
          giftInfoHelper(
            context,
            category: "종류",
            text: "모바일 교환권",
          ),
        ],
      ),
    );
  }
}

Widget giftInfoHelper(
  BuildContext context, {
  required String category,
  required String text,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    width: double.maxFinite,
    height: 30,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 1,
          color: Theme.of(context).colorScheme.outline.withOpacity(.2),
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          category,
          style: TextStyles.defaultStyle.copyWith(
            fontSize: 12,
            color: Theme.of(context).colorScheme.outline.withOpacity(.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          text,
          style: TextStyles.defaultStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
