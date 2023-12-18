import 'package:sirenorder_app/bloc/order/event/order_event.dart';

class RemoveMenuEvent extends OrderEvent {
  int index;
  RemoveMenuEvent(this.index);
  @override
  List<Object?> get props => [];
}
