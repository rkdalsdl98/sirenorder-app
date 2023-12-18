import 'package:sirenorder_app/bloc/order/event/order_event.dart';
import 'package:sirenorder_app/model/order_model.dart';

class PutMenuEvent extends OrderEvent {
  MenuModel menu;
  PutMenuEvent(this.menu);
  @override
  List<Object?> get props => [];
}
