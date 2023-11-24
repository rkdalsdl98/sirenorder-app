import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:sirenorder_app/bloc/regist/event/clear_event.dart';
import 'package:sirenorder_app/bloc/regist/event/create_user_event.dart';
import 'package:sirenorder_app/bloc/regist/event/regist_event.dart';
import 'package:sirenorder_app/bloc/regist/event/publish_code_event.dart';
import 'package:sirenorder_app/bloc/regist/event/send_code_event.dart';
import 'package:sirenorder_app/bloc/regist/handler/clear_event_handler.dart';
import 'package:sirenorder_app/bloc/regist/handler/create_user_event_handler.dart';
import 'package:sirenorder_app/bloc/regist/handler/publish_code_event_handler.dart';
import 'package:sirenorder_app/bloc/regist/handler/send_code_event_handler.dart';
import 'package:sirenorder_app/bloc/regist/regist_bloc_state.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class RegistBloc extends Bloc<RegistEvent, RegistBlocState> {
  final UserRepository _repository;
  RegistBloc(this._repository) : super(RegistBlocInitState(false, false)) {
    on<PublishCodeEvent>(
      (event, emit) async {
        await publishCode(emit, event);
      },
      transformer: droppable(),
    );

    on<SendCodeEvent>(
      (event, emit) async {
        await sendCode(emit, event);
      },
      transformer: droppable(),
    );

    on<ClearEvent>(
      (event, emit) {
        clear(emit, event);
      },
      transformer: droppable(),
    );

    on<CreateUserEvent>(
      (event, emit) async {
        await createUser(emit, event);
      },
      transformer: droppable(),
    );
  }

  clear(emit, RegistEvent event) {
    ClearEventHandler().handleEvent(emit, event, state);
  }

  publishCode(emit, RegistEvent event) async {
    try {
      await PublishCodeEventHandler().handleEvent(
        emit,
        event,
        state,
        repository: _repository,
      );
    } catch (e) {
      if (e is BlocException) {
        emit(RegistBlocErrorState(state.authEmail, state.pulishCode, e));
        return;
      }
      emit(
        RegistBlocErrorState(
          state.authEmail,
          state.pulishCode,
          BlocException(
            e.toString(),
            ExceptionType.UnknownException,
          ),
        ),
      );
    }
  }

  sendCode(emit, RegistEvent event) async {
    try {
      await SendCodeEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      if (e is BlocException) {
        emit(RegistBlocErrorState(state.authEmail, state.pulishCode, e));
        return;
      }
      emit(
        RegistBlocErrorState(
          state.authEmail,
          state.pulishCode,
          BlocException(
            e.toString(),
            ExceptionType.UnknownException,
          ),
        ),
      );
    }
  }

  createUser(emit, RegistEvent event) async {
    try {
      await CreateUserEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      if (e is BlocException) {
        emit(RegistBlocErrorState(state.authEmail, state.pulishCode, e));
        return;
      }
      emit(
        RegistBlocErrorState(
          state.authEmail,
          state.pulishCode,
          BlocException(
            e.toString(),
            ExceptionType.UnknownException,
          ),
        ),
      );
    }
  }
}
