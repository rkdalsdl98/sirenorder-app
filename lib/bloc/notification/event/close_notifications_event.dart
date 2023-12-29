import 'package:sirenorder_app/bloc/notification/event/notification_event.dart';

class CloseNotificationsEvent extends NotificationEvent {
  String? message;
  Duration? messageDuration;
  CloseNotificationsEvent(this.message, this.messageDuration);
  @override
  List<Object?> get props => [];
}
