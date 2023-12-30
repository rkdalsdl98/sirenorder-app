import 'package:sirenorder_app/bloc/menu/event/clear_menu_detail_event.dart';
import 'package:sirenorder_app/bloc/menu/event/menu_event.dart';
import 'package:sirenorder_app/bloc/menu/handler/menu_event_handler.dart';
import 'package:sirenorder_app/bloc/menu/menu_state.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class ClearMenuDetailEventHandler extends MenuEventHandler {
  @override
  handleEvent(
    emit,
    MenuEvent event,
    MenuBlocState state,
  ) {
    if (event is! ClearMenuDetailEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }
    emit(MenuBlocLoadingState(state.menus, null));
    emit(MenuBlocLoadedState(state.menus, null));
  }
}
