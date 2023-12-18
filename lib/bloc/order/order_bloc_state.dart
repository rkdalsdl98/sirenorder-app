import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

abstract class OrderBlocState extends Equatable {
  Map<String, dynamic> data;
  List<MenuModel> basket;
  OrderBlocState(this.data, this.basket);
}

class OrderBlocInitState extends OrderBlocState {
  OrderBlocInitState() : super({}, []);
  @override
  List<Object?> get props => [];
}

class OrderBlocLoadingtate extends OrderBlocState {
  OrderBlocLoadingtate(super.data, super.basket);
  @override
  List<Object?> get props => [];
}

class OrderBlocLoadedState extends OrderBlocState {
  OrderBlocLoadedState(super.data, super.basket);
  @override
  List<Object?> get props => [];
}

class OrderBlocErrorState extends OrderBlocState {
  BlocException exception;
  OrderBlocErrorState(super.data, super.basket, this.exception);
  @override
  List<Object?> get props => [];
}
