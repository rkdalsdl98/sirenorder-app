import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/model/user_model.dart';

class UpdateGiftEvent extends UserEvent {
  GiftModel gift;
  UpdateGiftEvent(this.gift);
  @override
  List<Object?> get props => [gift];
}
