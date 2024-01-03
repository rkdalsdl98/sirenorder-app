import 'package:flutter/material.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/system/methods.dart';
import 'package:sirenorder_app/widget/common/rounded_button_medium.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:intl/intl.dart';

class BillDetailDialog extends StatelessWidget {
  final List<DeliveryInfo> deliveryinfos;
  final List<MenuModel> menus;
  final dynamic totalprice;
  final String storeName;
  final String orderedAt;
  const BillDetailDialog({
    super.key,
    required this.deliveryinfos,
    required this.menus,
    required this.totalprice,
    required this.storeName,
    required this.orderedAt,
  });

  @override
  Widget build(BuildContext context) {
    int index = -1;
    return AlertDialog(
      content: Container(
        padding: const EdgeInsets.only(top: 15),
        width: 300 * getScaleWidth(context),
        height: 460 * getScaleHeight(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              storeName,
              style: TextStyles.titleStyle.copyWith(
                fontSize: 20,
              ),
            ),
            Expanded(
              child: PageView(
                children: menus.map<Widget>((_) {
                  ++index;
                  return menuInfoWrapper(
                    context,
                    deliveryinfo: deliveryinfos[index],
                    menuinfo: menus[index],
                  );
                }).toList(),
              ),
            ),
            if (orderedAt.isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  DateFormat("yyyy년 MM월 dd일").format(DateTime.parse(orderedAt)),
                  style: TextStyles.defaultStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(.6),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "총 합계: ${totalprice is String ? totalprice : addComma(totalprice)}원",
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            RoundedButtonMedium(
              text: "닫기",
              backgroundColor: Theme.of(context).colorScheme.background,
              textColor: const Color(0xFF1CBA3E),
              onTab: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuInfoWrapper(
    BuildContext context, {
    required DeliveryInfo deliveryinfo,
    required MenuModel menuinfo,
  }) {
    final style = TextStyles.defaultStyle.copyWith(
      fontSize: 15,
      height: 2,
    );
    final border = BorderSide(
      color: Theme.of(context).colorScheme.outline.withOpacity(.2),
      width: 5,
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: border,
          top: border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 120 * getScaleWidth(context),
              height: 120 * getScaleHeight(context),
              decoration: menuinfo.thumbnail != null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      image: DecorationImage(
                        image: NetworkImage(
                          menuinfo.thumbnail,
                        ),
                        fit: BoxFit.cover,
                      ),
                    )
                  : null,
              child: menuinfo.thumbnail == null
                  ? Center(
                      child: Text(
                      "미리보기 이미지가 없는 메뉴입니다.",
                      style: TextStyles.defaultStyle.copyWith(
                        fontSize: 18,
                      ),
                    ))
                  : null,
            ),
          ),
          Text(
            "메뉴: ${menuinfo.name ?? ""} (${deliveryinfo.tempture})",
            style: style.copyWith(
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "개수: ${menuinfo.count ?? 0}개",
            style: style,
          ),
          Text(
            "사이즈: ${deliveryinfo.size}",
            style: style,
          ),
          Text(
            "컵: ${deliveryinfo.packagingMethod}",
            style: style,
          ),
          Text(
            "픽업방식: ${deliveryinfo.take ? "포장" : "매장취식"}",
            style: style,
          ),
        ],
      ),
    );
  }
}
