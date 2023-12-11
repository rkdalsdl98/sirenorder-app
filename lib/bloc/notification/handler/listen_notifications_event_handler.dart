import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:sirenorder_app/bloc/notification/event/listen_notifications_event.dart';
import 'package:sirenorder_app/bloc/notification/event/notification_event.dart';
import 'package:sirenorder_app/bloc/notification/event/sse_notify_event.dart';
import 'package:sirenorder_app/bloc/notification/handler/notification_event_handler.dart';
import 'package:sirenorder_app/bloc/notification/notification_bloc.dart';
import 'package:sirenorder_app/bloc/notification/notification_state.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';
import 'package:sirenorder_app/model/subject.model.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class ListenNotificationsEventHandler extends NotificationEventHandler {
  @override
  handleEvent(
    emit,
    NotificationEvent event,
    NotificationBlocState state, {
    NotificationBloc? bloc,
  }) async {
    if (event is! ListenNotificationsEvent || bloc == null) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }

    if (state.subscription == null) {
      final subscription = await getSubscription(event.userEmail, bloc);
      emit(NotificationBlocListeningState(subscription, state.subject));
    }
  }

  StreamTransformer<Uint8List, List<int>> unit8Transformer() {
    return StreamTransformer.fromHandlers(handleData: (data, sink) {
      sink.add(List<int>.from(data));
    });
  }

  void onData(
    String data,
    NotificationBloc bloc,
  ) {
    final splitData = data.split(": ");
    final key = splitData[0];
    if (key == "data") {
      bloc.add(SSENotifyEvent(SSESubject.fromJson(jsonDecode(splitData[1]))));
    }
  }

  Future<StreamSubscription<String>> getSubscription(
    String userEmail,
    NotificationBloc bloc,
  ) async {
    final stream =
        (await sse(queryParams: {"listener_email": userEmail})).data?.stream;
    if (stream == null) {
      throw BlocException(
        "서버와 연결이 불안정하여 알림을 받아올 수 없습니다.",
        ExceptionType.ServiceUnavailableException,
      );
    }
    return stream
        .transform(unit8Transformer())
        .transform(const Utf8Decoder())
        .transform(const LineSplitter())
        .listen((event) => onData(event, bloc));
  }
}
