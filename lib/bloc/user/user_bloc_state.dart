import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/user_model.dart';

import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

abstract class UserBlocState extends Equatable {
  UserModel? user;
  UserBlocState(this.user);
}

class UserBlocInitState extends UserBlocState {
  UserBlocInitState(super.user);

  @override
  List<Object?> get props => [];
}

class UserBlocLoadingState extends UserBlocState {
  UserBlocLoadingState(super.user);

  @override
  List<Object?> get props => [];
}

class UserBlocLoadedState extends UserBlocState {
  UserBlocLoadedState(super.user);

  @override
  List<Object?> get props => [];
}

class UserBlocErrorState extends UserBlocState {
  final BlocException exception;
  UserBlocErrorState(super.user, this.exception);

  @override
  List<Object?> get props => [exception];
}
