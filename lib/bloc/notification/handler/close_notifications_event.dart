import 'package:sirenorder_app/bloc/notification/event/close_notifications_event.dart';
import 'package:sirenorder_app/bloc/notification/event/notification_event.dart';
import 'package:sirenorder_app/bloc/notification/handler/notification_event_handler.dart';
import 'package:sirenorder_app/bloc/notification/notification_state.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class CloseNotificationsEventHandler extends NotificationEventHandler {
  @override
  handleEvent(
    emit,
    NotificationEvent event,
    NotificationBlocState state,
  ) {
    if (event is! CloseNotificationsEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }

    state.close();
    emit(NotificationBlocIdleState(null, null));
  }
}
