import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/subject.model.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';
import 'package:sirenorder_app/type/sse/sse_response.dart';

abstract class NotificationBlocState extends Equatable {
  SSEConnection? listener;
  SSESubject? subject;
  NotificationBlocState(this.listener, this.subject);

  Future<void> close() async {
    await listener?.stream.cancel();
    listener?.conn.close();
    listener = null;
    subject = null;
  }
}

class NotificationBlocIdleState extends NotificationBlocState {
  NotificationBlocIdleState(super.listener, super.subject);
  @override
  List<Object?> get props => [listener];
}

class NotificationBlocCloseState extends NotificationBlocState {
  String? message;
  NotificationBlocCloseState(this.message, super.listener, super.subject);
  @override
  List<Object?> get props => [listener];
}

class NotificationBlocListeningState extends NotificationBlocState {
  NotificationBlocListeningState(super.listener, super.subject);
  @override
  List<Object?> get props => [listener];
}

class NotificationBlocReceiveState extends NotificationBlocState {
  NotificationBlocReceiveState(super.listener, super.subject);
  @override
  List<Object?> get props => [listener];
}

class NotificationBlocErrorState extends NotificationBlocState {
  final BlocException exception;
  NotificationBlocErrorState(super.listener, super.subject, this.exception);
  @override
  List<Object?> get props => [exception];
}
