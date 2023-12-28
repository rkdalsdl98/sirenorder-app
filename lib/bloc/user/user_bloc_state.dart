import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

abstract class UserBlocState extends Equatable {
  UserModel? user;
  Timer? _timer;

  UserBlocState(this.user);

  removeListener() {
    _timer?.cancel();
    _timer = null;
  }
}

class UserBlocInitState extends UserBlocState {
  UserBlocInitState(super.user);

  @override
  List<Object?> get props => [user];
}

class UserBlocLoadingState extends UserBlocState {
  UserBlocLoadingState(super.user);

  @override
  List<Object?> get props => [user];
}

class UserBlocLoadedState extends UserBlocState {
  UserBlocLoadedState(super.user);

  @override
  List<Object?> get props => [user];
}

class UserBlocErrorState extends UserBlocState {
  final BlocException exception;
  UserBlocErrorState(super.user, this.exception);

  @override
  List<Object?> get props => [user, exception];
}
