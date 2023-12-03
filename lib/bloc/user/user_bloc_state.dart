import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

abstract class UserBlocState extends Equatable {
  UserModel? user;
  OrderState? orderState;
  Timer? _timer;

  UserBlocState(this.user, this.orderState);

  listenOrderState(dynamic callback) {
    if (_timer != null) {
      throw BlocException(
        "이미 진행중인 주문이 있습니다.",
        ExceptionType.AlreadySubscribeStreamException,
      );
    }
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        callback();
      },
    );
  }

  removeListener() {
    _timer?.cancel();
    _timer = null;
  }
}

class UserBlocInitState extends UserBlocState {
  UserBlocInitState(super.user, super.orderState);

  @override
  List<Object?> get props => [user];
}

class UserBlocLoadingState extends UserBlocState {
  UserBlocLoadingState(super.user, super.orderState);

  @override
  List<Object?> get props => [user];
}

class UserBlocLoadedState extends UserBlocState {
  UserBlocLoadedState(super.user, super.orderState);

  @override
  List<Object?> get props => [user];
}

class UserBlocNotifyState extends UserBlocState {
  UserBlocNotifyState(super.user, super.orderState);

  @override
  List<Object?> get props => [user];
}

class UserBlocErrorState extends UserBlocState {
  final BlocException exception;
  UserBlocErrorState(super.user, super.orderState, this.exception);

  @override
  List<Object?> get props => [user, exception];
}
