import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

class StampContainer extends StatelessWidget {
  const StampContainer({
    super.key,
    required this.stampSize,
  });

  final double stampSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 15),
      width: 170 * getScaleWidth(context),
      height: 120 * getScaleHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "내 스탬프",
                style: TextStyles.titleStyle.copyWith(fontSize: 14),
              ),
              Text(
                "6개를 모으면 아메리카노 한잔이 무료에요!",
                style: TextStyles.defaultStyle.copyWith(fontSize: 6),
              ),
            ],
          ),
          stampWrapHelper(context, stampSize),
        ],
      ),
    );
  }
}

Widget stampWrapHelper(BuildContext context, double size) {
  int stars = context.read<UserBloc>().state.user!.wallet!.stars!;
  List<Widget> col = [];
  List<Widget> row = [];
  int count = 0;
  for (int i = 0; i <= 6; ++i) {
    if (count == 3) {
      col.add(Row(children: row));
      count = 0;
      row = [];
    }
    row.add(Image.asset(
      stars > 0
          ? "assets/img/stamp_active.png"
          : "assets/img/stamp_deactive.png",
      width: size * getScaleWidth(context),
      height: size * getScaleHeight(context),
    ));
    --stars;
    ++count;
  }
  return Column(children: col);
}
