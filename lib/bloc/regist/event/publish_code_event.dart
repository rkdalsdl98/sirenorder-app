import 'package:sirenorder_app/bloc/regist/event/regist_event.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';

class PublishCodeEvent extends RegistEvent {
  RequestRoute route;
  Map<String, dynamic>? queryparams;
  PublishCodeEvent(this.route, this.queryparams);

  @override
  List<Object?> get props => [route];
}
