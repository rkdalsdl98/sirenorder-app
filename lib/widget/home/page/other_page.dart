import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/notification/event/close_notifications_event.dart';
import 'package:sirenorder_app/bloc/notification/notification_bloc.dart';
import 'package:sirenorder_app/bloc/user/event/user_logout_event.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;
import 'package:sirenorder_app/system/dimenssion.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/type/other_menu_content.dart';
import 'package:sirenorder_app/widget/common/rounded_button_medium.dart';
import 'package:sirenorder_app/widget/home/page/other/other_menu_contents.dart';
import 'package:sirenorder_app/widget/home/page/other/other_page_menus.dart';
import 'package:sirenorder_app/widget/home/page/other/other_service.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  logout(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    final notifyBloc = context.read<NotificationBloc>();
    notifyBloc.add(CloseNotificationsEvent());
    userBloc.add(UserLogoutEvent());
  }

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
                  BlocBuilder<UserBloc, UserBlocState>(builder: (_, state) {
                    final user = state.user;
                    if (user != null) {
                      return logoutHelper(context);
                    }
                    return const OtherService();
                  }),
                  const OtherPageMenus(),
                  OtherMenuContents(
                    menuname: "Pay",
                    contents: [
                      OtherMenuContent(
                        "쿠폰 사용",
                        "assets/img/ticket.png",
                        () {},
                      ),
                      OtherMenuContent(
                        "쿠폰 내역",
                        "assets/img/ticket.png",
                        () {},
                      ),
                    ],
                  ),
                  OtherMenuContents(
                    menuname: "Order",
                    contents: [
                      OtherMenuContent(
                        "선물함",
                        "assets/img/bag.png",
                        () {
                          final user = context.read<UserBloc>().state.user;
                          if (user == null) {
                            showSnackBarMessage(context, "로그인이 필요한 서비스 입니다.");
                            return;
                          }
                          Navigator.pushNamed(context, "/gift-box");
                        },
                      ),
                      OtherMenuContent(
                        "구매 내역",
                        "assets/img/history.png",
                        () {},
                      ),
                    ],
                  ),
                  OtherMenuContents(
                    menuname: "고객지원",
                    contents: [
                      OtherMenuContent(
                        "스토어 혜택",
                        "assets/img/storecare.png",
                        () {},
                      ),
                      OtherMenuContent(
                        "문의하기",
                        "assets/img/help.png",
                        () {},
                      ),
                      OtherMenuContent(
                        "내 리뷰보기",
                        "assets/img/review.png",
                        () {},
                      ),
                      OtherMenuContent(
                        "매장정보",
                        "assets/img/location.png",
                        () {},
                      ),
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

  Widget logoutHelper(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 100 * getScaleWidth(context),
        height: 30 * getScaleHeight(context),
        child: RoundedButtonMedium(
          text: "로그아웃",
          onTab: () => logout(context),
        ),
      ),
    );
  }
}
