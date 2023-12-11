import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/user_model.dart';

class SSESubject {
  late final String notifyType;
  late final NofifySubject subject;

  SSESubject.fromJson(Map<String, dynamic> json) {
    notifyType = json['notify_type'];

    switch (notifyType) {
      case "update-notify":
      case "event-notify":
      case "main-notify":
        subject = ServerNotifySubject.fromJson(json['subject']);
        break;
      case "gift-notify":
        subject = GiftNotifySubject.fromJson(json['subject']);
        break;
      case "order-notify":
        subject = OrderNotifySubject.fromJson(json['subject']);
    }
  }
}

abstract class NofifySubject extends Equatable {}

class ServerNotifySubject extends NofifySubject {
  late final String message, title;
  ServerNotifySubject.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        title = json['title'];

  @override
  List<Object?> get props => [message, title];
}

class GiftNotifySubject extends NofifySubject {
  late final GiftModel gift;
  GiftNotifySubject.fromJson(Map<String, dynamic> json)
      : gift = GiftModel.fromJson(json['gift']);

  @override
  List<Object?> get props => [gift];
}

class OrderNotifySubject extends NofifySubject {
  late final OrderState state;
  OrderNotifySubject.fromJson(Map<String, dynamic> json) {
    final String stateStr = json['order_state'];
    switch (stateStr) {
      case "wait":
        state = OrderState.wait;
        break;
      case "refuse":
        state = OrderState.refuse;
        break;
      case "accept":
        state = OrderState.accept;
        break;
      case "finish":
        state = OrderState.finish;
        break;
    }
  }
  @override
  List<Object?> get props => [state];
}
