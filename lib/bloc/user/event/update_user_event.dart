import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/model/user_model.dart';

class UpdateUserEvent extends UserEvent {
  final int increasePoint, increaseStars;
  final OrderHistory history;
  UpdateUserEvent(this.increasePoint, this.increaseStars, this.history);
  @override
  List<Object?> get props => [];
}
