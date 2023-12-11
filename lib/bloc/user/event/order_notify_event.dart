import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/model/user_model.dart';

class OrderNotifyEvent extends UserEvent {
  OrderState? orderState;
  OrderNotifyEvent(this.orderState);

  @override
  List<Object?> get props => [];
}
