import 'package:sirenorder_app/bloc/regist/event/regist_event.dart';

class CreateUserEvent extends RegistEvent {
  String email;
  CreateUserEvent(this.email);
  @override
  List<Object?> get props => [];
}
