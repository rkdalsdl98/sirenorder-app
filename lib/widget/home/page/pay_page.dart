import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/dimenssion.dart';

class PayPage extends StatelessWidget {
  const PayPage({super.key});

  String addComma(int number) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return "$number".replaceAllMapped(reg, mathFunc);
  }

  Widget showUserPoint(String point) {
    return RichText(
      text: TextSpan(
        text: "사용가능한 포인트 ",
        style: TextStyles.titleStyle.copyWith(fontSize: 12),
        children: [
          TextSpan(
            text: "$point P",
            style: const TextStyle(color: Color(0xFF1CBA3E)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            BlocBuilder<UserBloc, UserBlocState>(builder: (_, state) {
              final user = state.user;
              return Container(
                margin: const EdgeInsets.only(top: 40),
                width: double.maxFinite,
                height: 50 * getScaleHeight(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Point",
                      style: TextStyles.titleStyle.copyWith(fontSize: 16),
                    ),
                    if (user != null)
                      RichText(
                        text: TextSpan(
                          text: "사용가능한 포인트  ",
                          style: TextStyles.titleStyle.copyWith(fontSize: 12),
                          children: [
                            TextSpan(
                              text: "${addComma(user.wallet!.point!)} P",
                              style: const TextStyle(
                                  color: Color(0xFF1CBA3E), fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    if (user == null)
                      const Text(
                        "포인트 충전은 로그인 이후에 사용이 가능합니다.",
                        style: TextStyles.defaultStyle,
                      ),
                  ],
                ),
              );
            }),
            SizedBox(height: 20 * getScaleHeight(context)),
            SizedBox(
              width: double.maxFinite,
              height: 360 * getScaleHeight(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Card",
                    style: TextStyles.titleStyle.copyWith(fontSize: 16),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .shadow
                                .withOpacity(.5),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ]),
                    width: 350 * getScaleWidth(context),
                    height: 320 * getScaleHeight(context),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/img/empty_card.png",
                          width: 250 * getScaleWidth(context),
                          height: 125 * getScaleHeight(context),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "사이렌 오더 카드를 등록해보세요!\n",
                            style: TextStyles.titleStyle.copyWith(
                              fontSize: 16,
                              height: 1.8,
                            ),
                            children: const [
                              TextSpan(
                                text:
                                    "매장과 사이렌오더에서 쉽고 편리하게\n사용할 수 있고, 다양한 혜택을 받을 수 있습니다!",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
