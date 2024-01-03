import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:sirenorder_app/bloc/user/event/register_coupon_event.dart';
import 'package:sirenorder_app/bloc/user/event/update_gift_event.dart';
import 'package:sirenorder_app/bloc/user/event/update_user_event.dart';
import 'package:sirenorder_app/bloc/user/event/use_coupon_event.dart';
import 'package:sirenorder_app/bloc/user/event/use_stamp_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_login_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_logout_event.dart';
import 'package:sirenorder_app/bloc/user/handler/register_coupon_event_handler.dart';
import 'package:sirenorder_app/bloc/user/handler/update_gift_event_handler.dart';
import 'package:sirenorder_app/bloc/user/handler/update_user_event_handler.dart';
import 'package:sirenorder_app/bloc/user/handler/use_coupon_event_handler.dart';
import 'package:sirenorder_app/bloc/user/handler/use_stamp_event_handler.dart';
import 'package:sirenorder_app/bloc/user/handler/user_login_event_handler.dart';
import 'package:sirenorder_app/bloc/user/handler/user_logout_event_handler.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class UserBloc extends Bloc<UserEvent, UserBlocState> {
  final UserRepository _repository;
  UserBloc(this._repository) : super(UserBlocInitState(null)) {
    on<UserLoginEvent>(
      (event, emit) async {
        await loginUser(emit, event);
      },
      transformer: droppable(),
    );
    on<UserLogoutEvent>(
      (event, emit) async {
        await logoutUser(emit, event);
      },
      transformer: sequential(),
    );
    on<UpdateGiftEvent>((event, emit) {
      updateGift(emit, event);
    });
    on<RegisterCouponEvent>(
      (event, emit) async {
        await registerCoupon(emit, event);
      },
      transformer: droppable(),
    );
    on<UseCouponEvent>(
      (event, emit) async {
        await useCoupon(emit, event);
      },
      transformer: droppable(),
    );
    on<UpdateUserEvent>(
      (event, emit) {
        updateUser(emit, event);
      },
      transformer: sequential(),
    );
    on<UseStampEvent>(
      (event, emit) async {
        await useStamp(emit, event);
      },
      transformer: droppable(),
    );
  }

  useStamp(emit, UseStampEvent event) async {
    try {
      await UseStampEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  updateUser(emit, UserEvent event) {
    try {
      UpdateUserEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  useCoupon(emit, UserEvent event) async {
    try {
      await UseCouponEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  registerCoupon(emit, UserEvent event) async {
    try {
      await RegisterCouponEventHandler().handleEvent(
        emit,
        event,
        state,
        repository: _repository,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  updateGift(emit, UserEvent event) {
    try {
      UpdateGiftEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  loginUser(emit, UserEvent event) async {
    try {
      await UserLoginEventHandler().handleEvent(
        emit,
        event,
        state,
        repository: _repository,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  logoutUser(emit, UserEvent event) async {
    try {
      await UserLogoutEventHandler().handleEvent(
        emit,
        event,
        state,
        repository: _repository,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  handleException(emit, error) {
    if (error is BlocException) {
      emit(UserBlocErrorState(state.user, error));
      return;
    } else if (error is DioException) {
      final dioException = DIOEXCEPTION[error.type];
      if (dioException != null) {
        emit(UserBlocErrorState(
          state.user,
          BlocException(
            dioException,
            ExceptionType.APIException,
          ),
        ));
      }
    } else {
      emit(
        UserBlocErrorState(
          state.user,
          BlocException(
            error.toString(),
            ExceptionType.UnknownException,
          ),
        ),
      );
    }
  }
}
