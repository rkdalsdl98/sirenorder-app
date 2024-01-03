import 'package:sirenorder_app/bloc/user/event/update_user_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/bloc/user/handler/user_event_handler.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class UpdateUserEventHandler extends UserEventHandler {
  @override
  handleEvent(
    emit,
    UserEvent event,
    UserBlocState state, {
    UserRepository? repository,
  }) {
    if (event is! UpdateUserEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }
    emit(UserBlocLoadedState(state.user));
    state.user!.wallet!.point =
        (state.user!.wallet!.point ?? 0) + event.increasePoint;
    state.user!.wallet!.stars =
        (state.user!.wallet!.stars ?? 0) + event.increaseStars;
    state.user!.orderhistory!.add(event.history);
    emit(UserBlocLoadedState(state.user));
  }
}
