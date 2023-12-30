import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/notification/event/close_notifications_event.dart';
import 'package:sirenorder_app/bloc/notification/notification_bloc.dart';
import 'package:sirenorder_app/bloc/notification/notification_state.dart';
import 'package:sirenorder_app/bloc/user/event/user_logout_event.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/widget/common/appmeunbar.dart';
import 'package:sirenorder_app/widget/home/page/home_page.dart';
import 'package:sirenorder_app/widget/home/page/order_page.dart';
import 'package:sirenorder_app/widget/home/page/other_page.dart';
import 'package:sirenorder_app/widget/home/page/pay_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currIndex = 0;

  void onChangeIndex(int value) => setState(() {
        currIndex = value;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppMenuBar(
        currIndex: currIndex,
        onChangeIndex: onChangeIndex,
      ),
      body: BlocBuilder<NotificationBloc, NotificationBlocState>(
          builder: (builderContext, state) {
        if (state is NotificationBlocReceiveState) {
          handleNotify(context, state.subject!);
        } else if (state is NotificationBlocCloseState &&
            state.message != null) {
          showSnackBarMessage(context, state.message!);
        } else if (state is NotificationBlocErrorState) {
          Future.delayed(Duration.zero).then((_) {
            builderContext.read<UserBloc>().add(UserLogoutEvent());
            builderContext.read<NotificationBloc>().add(CloseNotificationsEvent(
                  "유효하지 않은 로그인 정보로 로그아웃 됩니다.",
                  const Duration(milliseconds: 5),
                ));
          });
        }
        return IndexedStack(
          index: currIndex,
          children: const [
            HomePage(),
            PayPage(),
            OrderPage(),
            OtherPage(),
          ],
        );
      }),
    );
  }
}
