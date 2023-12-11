import 'package:flutter/material.dart';
import 'package:sirenorder_app/model/subject.model.dart';
import 'package:sirenorder_app/model/user_model.dart';

void showSnackBarMessage(
  BuildContext context,
  String message,
) {
  Future.delayed(Duration.zero).then(
    (_) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
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
    case "gift-notify":
      final giftSubject = sses.subject as GiftNotifySubject;
      showSnackBarMessage(
        context,
        "${giftSubject.gift.from}님께서 보낸 선물이 도착했어요!",
      );
      break;
    case "order-notify":
      final orderSubject = sses.subject as OrderNotifySubject;
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
      showSnackBarMessage(context, "주문요청 처리를 성공적으로 마무리 했습니다.");
      break;
  }
}
