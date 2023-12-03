import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/event/listen_notify_order_event.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/model/user_model.dart';
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
  OrderState? prevState;
  bool isLoading = false;
  bool showNotify = false;
  bool isListenNotify = false;

  void onChangeIndex(int value) => setState(() {
        currIndex = value;
      });

  handleNotifyMessage(OrderState notify) {
    switch (notify) {
      case OrderState.wait:
        showSnackBarMessage(context, "성공적으로 주문요청을 보냇습니다.");
        break;
      case OrderState.accept:
        showSnackBarMessage(context, "가게에서 주문을 수락하였습니다.");
        break;
      case OrderState.refuse:
        showSnackBarMessage(context, "가게에서 주문을 거절하였습니다.");
        break;
      case OrderState.finish:
        showSnackBarMessage(context, "주문요청 처리를 성공적으로 마무리 했습니다.");
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.args != null && widget.args!.isNotEmpty) {
      if (!isListenNotify) {
        final bloc = context.read<UserBloc>();
        bloc.add(ListenNotifyOrderEvent(widget.args!["merchant_uid"]));
        isListenNotify = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppMenuBar(
        currIndex: currIndex,
        onChangeIndex: onChangeIndex,
      ),
      body: BlocBuilder<UserBloc, UserBlocState>(builder: (_, state) {
        if (state is UserBlocNotifyState &&
            state.orderState != null &&
            !showNotify &&
            prevState != state.orderState) {
          handleNotifyMessage(state.orderState!);
          showNotify = true;
          prevState = state.orderState;
        } else {
          if (state is UserBlocErrorState) {
            showSnackBarMessage(
              context,
              state.exception.message,
            );
          }
          showNotify = false;
          isLoading = false;
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
