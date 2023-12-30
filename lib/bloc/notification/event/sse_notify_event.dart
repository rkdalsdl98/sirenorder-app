import 'package:sirenorder_app/bloc/notification/event/notification_event.dart';
import 'package:sirenorder_app/model/subject.model.dart';

class SSENotifyEvent extends NotificationEvent {
  final SSESubject subject;
  SSENotifyEvent(this.subject);
  @override
  List<Object?> get props => [subject];
}
