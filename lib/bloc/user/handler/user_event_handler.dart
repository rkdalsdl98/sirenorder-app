import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/respository/user_repository.dart';

abstract class UserEventHandler extends Equatable {
  handleEvent(
    emit,
    UserEvent event,
    UserRepository? repository,
  );
}
