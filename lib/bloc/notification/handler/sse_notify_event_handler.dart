import 'package:sirenorder_app/bloc/notification/event/notification_event.dart';
import 'package:sirenorder_app/bloc/notification/event/sse_notify_event.dart';
import 'package:sirenorder_app/bloc/notification/handler/notification_event_handler.dart';
import 'package:sirenorder_app/bloc/notification/notification_state.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class SSENotifyEventHandler extends NotificationEventHandler {
  @override
  handleEvent(
    emit,
    NotificationEvent event,
    NotificationBlocState state,
  ) async {
    if (event is! SSENotifyEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }

    if (state is! NotificationBlocListeningState) {
      emit(NotificationBlocListeningState(
        state.listener,
        state.subject,
      ));
    }

    await Future.delayed(const Duration(milliseconds: 100)).then((_) {
      emit(NotificationBlocReceiveState(
        state.listener,
        event.subject,
      ));
    });
  }
}
