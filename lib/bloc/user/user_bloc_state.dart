import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

abstract class UserBlocState extends Equatable {}

class UserBlocInitState extends UserBlocState {
  UserBlocInitState() : super();

  @override
  List<Object?> get props => [];
}

class UserBlocLoadingState extends UserBlocState {
  UserBlocLoadingState() : super();

  @override
  List<Object?> get props => [];
}

class UserBlocLoadedState extends UserBlocState {
  UserBlocLoadedState() : super();

  @override
  List<Object?> get props => [];
}

class UserBlocErrorState extends UserBlocState {
  final BlocException exception;
  UserBlocErrorState(this.exception) : super();

  @override
  List<Object?> get props => [];
}
