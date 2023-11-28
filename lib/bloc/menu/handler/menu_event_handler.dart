import 'package:sirenorder_app/bloc/menu/event/menu_event.dart';
import 'package:sirenorder_app/bloc/menu/menu_state.dart';

abstract class MenuEventHandler {
  handleEvent(
    emit,
    MenuEvent event,
    MenuBlocState state,
  ) {}
}
