import 'package:sirenorder_app/bloc/user/event/user_event.dart';

class RegisterCouponEvent extends UserEvent {
  final String userEmail, code;
  RegisterCouponEvent(this.userEmail, this.code);
  @override
  List<Object?> get props => [];
}
