import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/bloc/user/handler/user_event_handler.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/respository/user_repository.dart';

class SendOrderEventHandler extends UserEventHandler {
  @override
  handleEvent(
    emit,
    UserEvent event,
    UserBlocState state, {
    UserRepository? repository,
  }) {}
}
