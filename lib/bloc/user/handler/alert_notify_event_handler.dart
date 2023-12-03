import 'package:sirenorder_app/bloc/user/event/alert_notify_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/bloc/user/handler/user_event_handler.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class AlertNotifyEventHandler extends UserEventHandler {
  @override
  handleEvent(
    emit,
    UserEvent event,
    UserBlocState state, {
    UserRepository? repository,
  }) {
    if (event is! AlertNotifyEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.APIException,
      );
    }

    if (state is UserBlocNotifyState) {
      emit(UserBlocLoadedState(state.user, event.orderState));
    }

    emit(UserBlocNotifyState(state.user, event.orderState));
  }
}
