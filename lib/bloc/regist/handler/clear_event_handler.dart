import 'package:sirenorder_app/bloc/regist/event/clear_event.dart';
import 'package:sirenorder_app/bloc/regist/event/regist_event.dart';
import 'package:sirenorder_app/bloc/regist/handler/regist_event_handler.dart';
import 'package:sirenorder_app/bloc/regist/regist_bloc_state.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class ClearEventHandler extends RegistEventHandler {
  @override
  handleEvent(
    emit,
    RegistEvent event,
    RegistBlocState state, {
    UserRepository? repository,
  }) {
    if (event is! ClearEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }
    emit(RegistBlocInitState(false, false));
  }
}
