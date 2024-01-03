import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/user/event/update_gift_event.dart';
import 'package:sirenorder_app/bloc/user/event/update_user_event.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/model/subject.model.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/common/textstyles.dart' as TextStyles;

void showSnackBarMessage(
  BuildContext context,
  String message,
) {
  Future.delayed(Duration.zero).then(
    (_) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyles.defaultStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
    ),
  );
}

void handleNotify(BuildContext context, SSESubject sses) {
  final type = sses.notifyType;
  switch (type) {
    case "update-notify":
    case "event-notify":
    case "main-notify":
      final serverSubject = sses.subject as ServerNotifySubject;
      showSnackBarMessage(
        context,
        "${serverSubject.title}\n${serverSubject.message}",
      );
      break;
    case "user-notify":
      final userNotify = sses.subject as UserNotifySubject;
      showSnackBarMessage(
        context,
        "${userNotify.title}\n${userNotify.message}",
      );
      break;
    case "gift-notify":
      final giftSubject = sses.subject as GiftNotifySubject;
      showSnackBarMessage(
        context,
        "${giftSubject.gift.from}님께서 보낸 선물이 도착했어요!",
      );
      context.read<UserBloc>().add(UpdateGiftEvent(giftSubject.gift));
      break;
    case "order-notify":
      final orderSubject = sses.subject as OrderNotifySubject;
      final state = orderSubject.state;
      if (state == OrderState.finish) {
        context.read<UserBloc>().add(UpdateUserEvent(
              orderSubject.increasePoint ?? 0,
              orderSubject.increaseStars ?? 0,
              orderSubject.history!,
            ));
      }
      _handleOrderStateMessage(context, orderSubject.state);
      break;
  }
}

_handleOrderStateMessage(BuildContext context, OrderState state) {
  switch (state) {
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
      showSnackBarMessage(context, "음료가 완성되었습니다.\n매장에서 픽업해주세요!");
      break;
  }
}
