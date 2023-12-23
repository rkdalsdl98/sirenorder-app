import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/notification/notification_bloc.dart';
import 'package:sirenorder_app/bloc/notification/notification_state.dart';
import 'package:sirenorder_app/system/system_message.dart';
import 'package:sirenorder_app/widget/common/appmeunbar.dart';
import 'package:sirenorder_app/widget/home/page/home_page.dart';
import 'package:sirenorder_app/widget/home/page/order_page.dart';
import 'package:sirenorder_app/widget/home/page/other_page.dart';
import 'package:sirenorder_app/widget/home/page/pay_page.dart';

class Home extends StatefulWidget {
  Map<String, dynamic>? args;
  Home({
    super.key,
    this.args,
  });

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
          builder: (_, state) {
        if (state is NotificationBlocReceiveState) {
          handleNotify(context, state.subject!);
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
