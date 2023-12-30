import 'package:sirenorder_app/bloc/basket/event/basket_event.dart';
import 'package:sirenorder_app/model/basket_item_model.dart';

class PutMenuEvent extends BasketEvent {
  BasketItemModel item;
  PutMenuEvent(this.item);
  @override
  List<Object?> get props => [item];
}
