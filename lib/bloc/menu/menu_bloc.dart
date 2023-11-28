import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:sirenorder_app/bloc/menu/event/get_menu_list_event.dart';
import 'package:sirenorder_app/bloc/menu/event/menu_event.dart';
import 'package:sirenorder_app/bloc/menu/handler/get_menu_list_event_handler.dart';
import 'package:sirenorder_app/bloc/menu/menu_state.dart';
import 'package:sirenorder_app/respository/menu_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class MenuBloc extends Bloc<MenuEvent, MenuBlocState> {
  final MenuRepository _repository;
  MenuBloc(this._repository) : super(MenuBlocInitState(const [])) {
    on<GetMenuListEvent>(
      (event, emit) async {
        await getMenuList(emit, event);
      },
      transformer: droppable(),
    );
  }

  getMenuList(emit, MenuEvent event) async {
    try {
      await GetMenuListEventHandler().handleEvent(
        emit,
        event,
        state,
        repository: _repository,
      );
    } catch (e) {
      if (e is BlocException) {
        emit(MenuBlocErrorState(state.menus, e));
        return;
      }
      emit(
        MenuBlocErrorState(
          state.menus,
          BlocException(
            e.toString(),
            ExceptionType.UnknownException,
          ),
        ),
      );
    }
  }
}
