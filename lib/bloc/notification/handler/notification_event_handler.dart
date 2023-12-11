import 'package:sirenorder_app/bloc/notification/event/notification_event.dart';
import 'package:sirenorder_app/bloc/notification/notification_state.dart';

abstract class NotificationEventHandler {
  handleEvent(
    emit,
    NotificationEvent event,
    NotificationBlocState state,
  ) {}
}
