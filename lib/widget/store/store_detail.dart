import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/order/event/upsert_data_event.dart';
import 'package:sirenorder_app/bloc/order/order_bloc.dart';
import 'package:sirenorder_app/model/store_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/common/rounded_button_medium.dart';
import 'package:sirenorder_app/widget/common/rounded_button_small.dart';

class StoreDetail extends StatelessWidget {
  final StoreDetailModel detail;
  final String thumbnail;
  final String storename;
  final String address;
  StoreDetail({
    super.key,
    required this.thumbnail,
    required this.storename,
    required this.address,
    required this.detail,
  });
  bool? isTake;

  showPackageMethodSelector(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (builderContext) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 80),
        content: SizedBox(
          height: 60 * getScaleHeight(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "포장 유무 선택",
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButtonMedium(
                    text: "포장하기",
                    onTab: () => Navigator.pop(context, true),
                  ),
                  RoundedButtonMedium(
                    text: "매장취식",
                    onTab: () => Navigator.pop(context, false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).then((value) {
      if (value == null) {
        return;
      } else if (value is bool) {
        isTake = value;
        context.read<OrderBloc>().add(UpsertDataEvent("take", isTake));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: double.maxFinite,
      height: 600 * getScaleHeight(context),
      child: Column(
        children: [
          Container(
            width: 60 * getScaleWidth(context),
            height: 5,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(45),
            ),
          ),
          SizedBox(
            height: 480 * getScaleHeight(context),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    clipBehavior: Clip.hardEdge,
                    height: 200 * getScaleHeight(context),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(thumbnail),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    width: double.maxFinite,
                    height: 50 * getScaleHeight(context),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withOpacity(.2),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          storename,
                          style: TextStyles.defaultStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: const Color.fromARGB(255, 18, 165, 50),
                          ),
                        ),
                        Text(
                          address,
                          style: TextStyles.defaultStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 80 * getScaleHeight(context),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withOpacity(.2),
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(.5),
                        ),
                        SizedBox(width: 10 * getScaleWidth(context)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "가게 운영 시간",
                              style: TextStyles.defaultStyle.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 14,
                              ),
                            ),
                            hoursHelper(
                              context,
                              category: "매장",
                              hours: detail.openhours.mon!,
                            ),
                            hoursHelper(
                              context,
                              category: "사이렌 오더",
                              hours: detail.sirenorderhours.mon!,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 25),
                      width: 200 * getScaleWidth(context),
                      height: 100 * getScaleHeight(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "오시는 길",
                            style: TextStyles.titleStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            detail.waytocome,
                            style: TextStyles.defaultStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 30 * getScaleHeight(context),
            color: const Color(0xFFD9D9D9).withOpacity(.6),
            child: Center(
              child: Text(
                "수령장소에 따라 메뉴별 주문 가능 수량이 상이할 수 있습니다.",
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            width: double.maxFinite,
            height: 60 * getScaleHeight(context),
            child: RoundedButtonSmall(
              text: "매장 선택",
              fontSize: 14,
              onTab: () {
                showPackageMethodSelector(context).then((_) {
                  if (isTake != null) {
                    Navigator.pop(context, true);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget hoursHelper(
  BuildContext context, {
  required String category,
  required Hours hours,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    child: RichText(
      text: TextSpan(
        text: "ㄴ",
        style: TextStyles.titleStyle.copyWith(
          color: Theme.of(context).colorScheme.outline.withOpacity(.4),
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: "  $category",
            style: TextStyles.defaultStyle.copyWith(
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: "   ${hours.open} ~ ${hours.close}",
            style: TextStyles.defaultStyle.copyWith(
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
  );
}
