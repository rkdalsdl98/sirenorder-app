import 'package:sirenorder_app/bloc/notification/event/notification_event.dart';

class ListenNotificationsEvent extends NotificationEvent {
  final String userEmail;
  ListenNotificationsEvent(this.userEmail);
  @override
  List<Object?> get props => [];
}
