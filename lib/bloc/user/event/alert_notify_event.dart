import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/model/user_model.dart';

class AlertNotifyEvent extends UserEvent {
  OrderState orderState;
  AlertNotifyEvent(this.orderState);

  @override
  List<Object?> get props => [];
}
