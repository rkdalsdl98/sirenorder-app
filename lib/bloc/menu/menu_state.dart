import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

abstract class MenuBlocState extends Equatable {
  List<MenuModel> menus;
  MenuBlocState(this.menus);

  @override
  List<Object?> get props => [];
}

class MenuBlocInitState extends MenuBlocState {
  MenuBlocInitState(super.menus);

  @override
  List<Object?> get props => [];
}

class MenuBlocLoadingState extends MenuBlocState {
  MenuBlocLoadingState(super.menus);

  @override
  List<Object?> get props => [];
}

class MenuBlocLoadedState extends MenuBlocState {
  MenuBlocLoadedState(super.menus);
  @override
  List<Object?> get props => [];
}

class MenuBlocErrorState extends MenuBlocState {
  final BlocException exception;
  MenuBlocErrorState(super.menus, this.exception);

  @override
  List<Object?> get props => [exception];
}
