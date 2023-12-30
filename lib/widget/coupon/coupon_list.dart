import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sirenorder_app/bloc/order/event/clear_data_event.dart';
import 'package:sirenorder_app/bloc/order/order_bloc.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';
import 'package:sirenorder_app/widget/common/rounded_button_medium.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/widget/coupon/coupon_modal_bottom_sheet.dart';

class CouponList extends StatelessWidget {
  List<CouponModel> coupons;
  CouponList({super.key, required this.coupons});

  void showCouponModal(BuildContext context, CouponModel coupon) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builderContext) => CouponModalBottomSheet(coupon: coupon),
    ).then((value) {
      if (value is BlocException) {
        showSnackBarMessage(context, value.message);
      } else if (value is bool) {
        showSnackBarMessage(context, "장바구니에 메뉴를 담았습니다.");
      }
      context.read<OrderBloc>().add(ClearDataEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: coupons
              .map<Widget>(
                (coupon) => couponItemHelper(
                  context,
                  coupon,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget couponItemHelper(
    BuildContext context,
    CouponModel coupon,
  ) {
    return SizedBox(
      width: double.maxFinite,
      height: 100 * getScaleHeight(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 100 * getScaleWidth(context),
            height: 100 * getScaleHeight(context),
            child: coupon.thumbnail != null
                ? Image.network(
                    coupon.thumbnail!,
                    fit: BoxFit.contain,
                    errorBuilder: (errorContext, err, stack) {
                      String message = "미리보기 이미지가 없는 메뉴입니다.";
                      if (err is NetworkImageLoadException &&
                          (err.statusCode >= 400 && err.statusCode < 500)) {
                        message = "이미지를 찾을 수 없습니다.";
                      }
                      return messageHelper(message);
                    },
                  )
                : messageHelper("미리보기 이미지가 없는 메뉴입니다."),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                coupon.menu_name,
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                DateFormat("yyyy년 MM월 dd일").format(coupon.expirationPeriod),
                style: TextStyles.defaultStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30 * getScaleHeight(context),
            child: RoundedButtonMedium(
              text: "주문하기",
              onTab: () => showCouponModal(context, coupon),
            ),
          ),
        ],
      ),
    );
  }

  Widget messageHelper(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyles.defaultStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
