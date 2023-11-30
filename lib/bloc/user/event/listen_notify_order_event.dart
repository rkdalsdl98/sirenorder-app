import 'package:sirenorder_app/bloc/user/event/user_event.dart';

class ListenNotifyOrderEvent extends UserEvent {
  final String orderId;
  ListenNotifyOrderEvent(this.orderId);
  @override
  List<Object?> get props => [orderId];
}
