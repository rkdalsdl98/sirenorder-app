import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_logout_event.dart';
import 'package:sirenorder_app/bloc/user/handler/user_event_handler.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class UserLogoutEventHandler extends UserEventHandler {
  @override
  handleEvent(
    emit,
    UserEvent event,
    UserBlocState state, {
    UserRepository? repository,
  }) async {
    if (repository == null) {
      throw BlocException(
        "저장소 초기화에 실패했습니다.",
        ExceptionType.RepsitoryNotDefinedException,
      );
    } else if (event is! UserLogoutEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }
    await repository.deleteData("token");
    emit(UserBlocLoadedState(null));
  }
}
