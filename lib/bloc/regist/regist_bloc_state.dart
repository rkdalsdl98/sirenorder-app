import 'package:equatable/equatable.dart';

import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

abstract class RegistBlocState extends Equatable {
  bool authEmail;
  bool pulishCode;
  RegistBlocState(this.authEmail, this.pulishCode);
}

class RegistBlocInitState extends RegistBlocState {
  RegistBlocInitState(super.authEmail, super.pulishCode);
  @override
  List<Object?> get props => [];
}

class RegistBlocLoadingState extends RegistBlocState {
  RegistBlocLoadingState(super.authEmail, super.pulishCode);
  @override
  List<Object?> get props => [];
}

class RegistBlocLoadedState extends RegistBlocState {
  RegistBlocLoadedState(super.authEmail, super.pulishCode);
  @override
  List<Object?> get props => [];
}

class RegistBlocCreatedState extends RegistBlocState {
  RegistBlocCreatedState(super.authEmail, super.pulishCode);
  @override
  List<Object?> get props => [];
}

class RegistBlocErrorState extends RegistBlocState {
  final BlocException exception;
  RegistBlocErrorState(super.authEmail, super.pulishCode, this.exception);

  @override
  List<Object?> get props => [exception];
}
