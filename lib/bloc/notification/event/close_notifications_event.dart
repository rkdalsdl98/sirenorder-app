import 'package:sirenorder_app/bloc/notification/event/notification_event.dart';

class CloseNotificationsEvent extends NotificationEvent {
  String? message;
  CloseNotificationsEvent(this.message);
  @override
  List<Object?> get props => [];
}
