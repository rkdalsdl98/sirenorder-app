import 'package:flutter/material.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/type/other_menu_content.dart';
import 'package:sirenorder_app/widget/home/page/other/other_menu_contents.dart';
import 'package:sirenorder_app/widget/home/page/other/other_page_menus.dart';
import 'package:sirenorder_app/widget/home/page/other/other_service.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order",
            style: TextStyles.titleStyle,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            width: double.maxFinite,
            height: 495 * getScaleHeight(context),
            color: const Color(0xFFF6F6F6),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const OtherService(),
                  const OtherPageMenus(),
                  OtherMenuContents(
                    menuname: "Pay",
                    contents: [
                      OtherMenuContent("쿠폰 등록", "assets/img/ticket.png"),
                      OtherMenuContent("쿠폰 내역", "assets/img/ticket.png"),
                    ],
                  ),
                  OtherMenuContents(
                    menuname: "Order",
                    contents: [
                      OtherMenuContent("장바구니", "assets/img/bag.png"),
                      OtherMenuContent("구매 내역", "assets/img/history.png"),
                    ],
                  ),
                  OtherMenuContents(
                    menuname: "고객지원",
                    contents: [
                      OtherMenuContent("스토어 혜택", "assets/img/storecare.png"),
                      OtherMenuContent("문의하기", "assets/img/help.png"),
                      OtherMenuContent("내 리뷰보기", "assets/img/review.png"),
                      OtherMenuContent("매장정보", "assets/img/location.png"),
                    ],
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
