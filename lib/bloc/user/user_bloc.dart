import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_login_event.dart';
import 'package:sirenorder_app/bloc/user/handler/user_login_event_handler.dart';
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
      if (e is BlocException) {
        emit(UserBlocErrorState(state.user, e));
        return;
      }
      emit(
        UserBlocErrorState(
          state.user,
          BlocException(
            e.toString(),
            ExceptionType.UnknownException,
          ),
        ),
      );
    }
  }
}
