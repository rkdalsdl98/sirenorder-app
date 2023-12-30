import 'package:sirenorder_app/bloc/basket/event/basket_event.dart';

class RemoveMenuEvent extends BasketEvent {
  int index;
  RemoveMenuEvent(this.index);
  @override
  List<Object?> get props => [];
}
