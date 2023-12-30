import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/type/bloc/user_login_request.dart';

class UserLoginEvent extends UserEvent {
  UserLoginRequest? typingLogin;
  String? tokenLogin;

  UserLoginEvent(this.tokenLogin, this.typingLogin);
  @override
  List<Object?> get props => [];
}
