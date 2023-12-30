import 'package:sirenorder_app/bloc/notification/event/notification_event.dart';

class ListenNotificationsEvent extends NotificationEvent {
  final String userEmail;
  final String accessToken;
  ListenNotificationsEvent(this.userEmail, this.accessToken);
  @override
  List<Object?> get props => [];
}
