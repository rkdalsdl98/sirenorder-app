import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/basket_item_model.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

abstract class BasketBlocState extends Equatable {
  List<BasketItemModel> basket;
  BasketBlocState(this.basket);
}

class BasketBlocInitState extends BasketBlocState {
  BasketBlocInitState() : super([]);
  @override
  List<Object?> get props => [];
}

class BasketBlocLoadingState extends BasketBlocState {
  BasketBlocLoadingState(super.basket);
  @override
  List<Object?> get props => [];
}

class BasketBlocLoadedState extends BasketBlocState {
  BasketBlocLoadedState(super.basket);
  @override
  List<Object?> get props => [];
}

class BasketBlocSuccessedActionState extends BasketBlocState {
  BasketBlocSuccessedActionState(super.basket);
  @override
  List<Object?> get props => [];
}

class BasketBlocErrorState extends BasketBlocState {
  BlocException exception;
  @override
  BasketBlocErrorState(super.basket, this.exception);
  @override
  List<Object?> get props => [];
}
