import 'package:sirenorder_app/bloc/regist/event/regist_event.dart';
import 'package:sirenorder_app/bloc/regist/regist_bloc_state.dart';
import 'package:sirenorder_app/respository/user_repository.dart';

abstract class RegistEventHandler {
  handleEvent(
    emit,
    RegistEvent event,
    RegistBlocState state, {
    UserRepository? repository,
  }) {}
}
