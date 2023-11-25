import 'package:equatable/equatable.dart';

class UserLoginRequest extends Equatable {
  final String email, pass;
  const UserLoginRequest(this.email, this.pass);

  @override
  List<Object?> get props => [email, pass];
}
