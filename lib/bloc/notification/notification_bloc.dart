import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/notification/event/close_notifications_event.dart';
import 'package:sirenorder_app/bloc/notification/event/listen_notifications_event.dart';
import 'package:sirenorder_app/bloc/notification/event/notification_event.dart';
import 'package:sirenorder_app/bloc/notification/event/sse_notify_event.dart';
import 'package:sirenorder_app/bloc/notification/handler/close_notifications_event_handler.dart';
import 'package:sirenorder_app/bloc/notification/handler/listen_notifications_event_handler.dart';
import 'package:sirenorder_app/bloc/notification/handler/sse_notify_event_handler.dart';
import 'package:sirenorder_app/bloc/notification/notification_state.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationBlocState> {
  NotificationBloc() : super(NotificationBlocIdleState(null, null)) {
    on<ListenNotificationsEvent>(
      (event, emit) async {
        await listenNotifications(emit, event);
      },
      transformer: droppable(),
    );
    on<SSENotifyEvent>(
      (event, emit) async {
        await receiveNotify(emit, event);
      },
      transformer: sequential(),
    );
    on<CloseNotificationsEvent>(
      (event, emit) async {
        await closeNotifications(emit, event);
      },
      transformer: sequential(),
    );
  }

  listenNotifications(
    emit,
    NotificationEvent event,
  ) async {
    try {
      await ListenNotificationsEventHandler().handleEvent(
        emit,
        event,
        state,
        bloc: this,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  closeNotifications(
    emit,
    NotificationEvent event,
  ) async {
    try {
      await CloseNotificationsEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  receiveNotify(
    emit,
    NotificationEvent event,
  ) async {
    try {
      await SSENotifyEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  handleException(emit, error) {
    state.close();
    if (error is BlocException) {
      emit(NotificationBlocErrorState(null, null, error));
      return;
    } else if (error is DioException) {
      final dioException = DIOEXCEPTION[error.type];
      if (dioException != null) {
        emit(NotificationBlocErrorState(
          null,
          null,
          BlocException(
            dioException,
            ExceptionType.APIException,
          ),
        ));
      }
    } else {
      emit(
        NotificationBlocErrorState(
          null,
          null,
          BlocException(
            error.toString(),
            ExceptionType.UnknownException,
          ),
        ),
      );
    }
  }
}
