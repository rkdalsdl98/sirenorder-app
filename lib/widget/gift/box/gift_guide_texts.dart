import 'package:flutter/material.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class GuideTexts extends StatelessWidget {
  const GuideTexts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: RichText(
            text: TextSpan(
                text: "[유의사항]\n",
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                children: const [
                  TextSpan(
                    text: "- 타 쿠폰 중복사용이나 포인트 적립 및 제휴카드 할인은 브랜드사 정책에 따릅니다.\n",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text:
                        "* 브랜드사 정책은 메가MGC 앱 > 스탬프 > [스탬프 적립 주의사항]에서 확인 가능합니다.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: RichText(
            text: TextSpan(
                text: "[잔액환불안내]\n",
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                children: const [
                  TextSpan(
                    text: "- 구매일로부터 5년 이내 사용 후 남은 잔액에 대해 환불신청 가능합니다.\n",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text:
                        "- 사용처에서는 잔액환불이 불가하며, 사이렌오더 마케팅 고객센터(1234-5678)를 통해 잔액 환불 가능합니다. (1만원권 이하는 80% 사용시, 1만원권 초과는 60% 이상 사용 시 환불 가능)",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
