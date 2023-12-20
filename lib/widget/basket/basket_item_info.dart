import 'package:flutter/material.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/methods.dart';
import 'package:sirenorder_app/widget/common/counter.dart';

class BasketItemInfo extends StatelessWidget {
  final DeliveryInfo info;
  final MenuModel menu;
  final int price;

  final void Function() decrementCount;
  final void Function() incrementCount;
  const BasketItemInfo({
    super.key,
    required this.info,
    required this.menu,
    required this.price,
    required this.decrementCount,
    required this.incrementCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120 * getScaleWidth(context),
          height: 120 * getScaleHeight(context),
          margin: const EdgeInsets.only(left: 15),
          decoration: menu.thumbnail.isNotEmpty
              ? BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(menu.thumbnail),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(360)),
                )
              : null,
          child: menu.thumbnail.isEmpty
              ? Text(
                  "미리보기 이미지가 없는 메뉴입니다.",
                  style: TextStyles.defaultStyle.copyWith(
                    fontSize: 18,
                  ),
                )
              : null,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 120 * getScaleHeight(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200 * getScaleWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "${menu.name}\n",
                        style: TextStyles.titleStyle.copyWith(
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: menu.en_name,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(.8),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${info.tempture} | ${info.size} | ${info.packagingMethod}",
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 12,
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(.8),
                          ),
                        ),
                        Text(
                          addComma(price),
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 200 * getScaleWidth(context),
                height: 50 * getScaleHeight(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "옵션변경",
                      style: TextStyles.defaultStyle.copyWith(
                        fontSize: 13,
                        color: const Color(0xFF6c3c0c),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Counter(
                          count: menu.count,
                          decrementCount: decrementCount,
                          incrementCount: incrementCount,
                          width: 70,
                          height: 30,
                          fontSize: 16,
                          buttonSize: 14,
                        ),
                        Text(
                          addComma(price * menu.count),
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
