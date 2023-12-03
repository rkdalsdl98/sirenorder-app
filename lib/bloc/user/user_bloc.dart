import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:sirenorder_app/bloc/user/event/alert_notify_event.dart';
import 'package:sirenorder_app/bloc/user/event/listen_notify_order_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_login_event.dart';
import 'package:sirenorder_app/bloc/user/handler/alert_notify_event_handler.dart';
import 'package:sirenorder_app/bloc/user/handler/listen_notify_order_event_handler.dart';
import 'package:sirenorder_app/bloc/user/handler/user_login_event_handler.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class UserBloc extends Bloc<UserEvent, UserBlocState> {
  final UserRepository _repository;
  UserBloc(this._repository) : super(UserBlocInitState(null, null)) {
    on<UserLoginEvent>(
      (event, emit) async {
        await loginUser(emit, event);
      },
      transformer: droppable(),
    );

    on<ListenNotifyOrderEvent>(
      (event, emit) async {
        await listenOrderNotify(emit, event);
      },
      transformer: restartable(),
    );

    on<AlertNotifyEvent>(
      (event, emit) async {
        alertNotify(emit, event);
      },
      transformer: droppable(),
    );
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

  alertNotify(emit, UserEvent event) {
    try {
      AlertNotifyEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      state.removeListener();
      handleException(emit, e);
    }
  }

  listenOrderNotify(emit, UserEvent event) async {
    try {
      await ListenNotifyOrderEventEventHandler().handleEvent(
        emit,
        event,
        state,
        bloc: this,
      );
    } catch (e) {
      state.removeListener();
      handleException(emit, e);
    }
  }

  handleException(emit, error) {
    if (error is BlocException) {
      emit(UserBlocErrorState(state.user, state.orderState, error));
      return;
    } else if (error is DioException) {
      final dioException = DIOEXCEPTION[error.type];
      if (dioException != null) {
        emit(UserBlocErrorState(
          state.user,
          state.orderState,
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
          state.orderState,
          BlocException(
            error.toString(),
            ExceptionType.UnknownException,
          ),
        ),
      );
    }
  }
}
