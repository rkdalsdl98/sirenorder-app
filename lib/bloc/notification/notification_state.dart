import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/subject.model.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

abstract class NotificationBlocState extends Equatable {
  StreamSubscription<String>? subscription;
  SSESubject? subject;
  NotificationBlocState(this.subscription, this.subject);

  void close() {
    subscription?.cancel();
    subscription = null;
    subject = null;
  }
}

class NotificationBlocIdleState extends NotificationBlocState {
  NotificationBlocIdleState(super.subscription, super.subject);
  @override
  List<Object?> get props => [];
}

class NotificationBlocListeningState extends NotificationBlocState {
  NotificationBlocListeningState(super.subscription, super.subject);
  @override
  List<Object?> get props => [];
}

class NotificationBlocReceiveState extends NotificationBlocState {
  NotificationBlocReceiveState(super.subscription, super.subject);
  @override
  List<Object?> get props => [];
}

class NotificationBlocErrorState extends NotificationBlocState {
  final BlocException exception;
  NotificationBlocErrorState(super.subscription, super.subject, this.exception);
  @override
  List<Object?> get props => [exception];
}
