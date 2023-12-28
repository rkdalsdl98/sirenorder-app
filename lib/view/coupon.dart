import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/widget/common/loading_indicator.dart';
import 'package:sirenorder_app/widget/coupon/coupon_register.dart';
import 'package:sirenorder_app/widget/coupon/coupon_list.dart';

class Coupon extends StatefulWidget {
  const Coupon({super.key});

  @override
  State<Coupon> createState() => _CouponState();
}

class _CouponState extends State<Coupon> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        radius: 0,
        highlightColor: Colors.transparent,
        child:
            BlocBuilder<UserBloc, UserBlocState>(builder: (blocContext, state) {
          final coupons = state.user!.coupons ?? [];
          if (state is UserBlocLoadingState) {
            isLoading = true;
          } else {
            if (state is UserBlocErrorState && isLoading) {
              showSnackBarMessage(context, state.exception.message);
            }
            isLoading = false;
          }
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleHelper(blocContext),
                  if (coupons.isEmpty) emptyHelper(context),
                  if (coupons.isNotEmpty)
                    CouponList(
                      coupons: coupons
                          .map<CouponModel>(
                              (json) => CouponModel.fromJson(json))
                          .toList(),
                    ),
                  CouponRegister(),
                ],
              ),
              if (isLoading) const LoadingIndicator()
            ],
          );
        }),
      ),
    );
  }
}

Widget emptyHelper(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "쿠폰함이 비어있어요!",
        style: TextStyles.titleStyle.copyWith(
          fontSize: 18,
        ),
      ),
      SizedBox(height: 10 * getScaleHeight(context)),
      Text(
        "발급받은 쿠폰이 있다면,\n하단 입력칸에 쿠폰번호를 입력하고 등록해보세요!",
        style: TextStyles.defaultStyle.copyWith(
          fontSize: 14,
          color: Theme.of(context).colorScheme.outline.withOpacity(.8),
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

Widget titleHelper(BuildContext context) {
  return SizedBox(
    height: 80 * getScaleHeight(context),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Navigator.pop<Map<String, dynamic>?>(
            context,
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            width: 25 * getScaleWidth(context),
            height: 25 * getScaleHeight(context),
            child: Text(
              "<",
              style: TextStyles.defaultStyle.copyWith(
                fontSize: 22,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.5),
              ),
            ),
          ),
        ),
        const Spacer(),
        Text(
          "쿠폰함",
          style: TextStyles.defaultStyle.copyWith(
            fontSize: 15,
          ),
        ),
        const Spacer(),
      ],
    ),
  );
}
