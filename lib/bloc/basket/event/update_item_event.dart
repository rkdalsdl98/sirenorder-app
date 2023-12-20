import 'package:sirenorder_app/bloc/basket/event/basket_event.dart';
import 'package:sirenorder_app/model/basket_item_model.dart';

class UpdateItemEvent extends BasketEvent {
  int index;
  BasketItemModel item;
  UpdateItemEvent(this.item, this.index);
  @override
  List<Object?> get props => [item, index];
}
