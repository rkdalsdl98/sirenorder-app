import 'package:sirenorder_app/bloc/regist/event/regist_event.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';

class SendCodeEvent extends RegistEvent {
  String code;
  RequestRoute route;
  SendCodeEvent(this.code, this.route);
  @override
  List<Object?> get props => [];
}
