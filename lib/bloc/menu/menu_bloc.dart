import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:sirenorder_app/bloc/menu/event/clear_menu_detail_event.dart';
import 'package:sirenorder_app/bloc/menu/event/get_menu_detail_event.dart';
import 'package:sirenorder_app/bloc/menu/event/get_menu_list_event.dart';
import 'package:sirenorder_app/bloc/menu/event/menu_event.dart';
import 'package:sirenorder_app/bloc/menu/handler/clear_menu_detail_event_handler.dart';
import 'package:sirenorder_app/bloc/menu/handler/get_menu_detail_event_handler.dart';
import 'package:sirenorder_app/bloc/menu/handler/get_menu_list_event_handler.dart';
import 'package:sirenorder_app/bloc/menu/menu_state.dart';
import 'package:sirenorder_app/respository/menu_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class MenuBloc extends Bloc<MenuEvent, MenuBlocState> {
  final MenuRepository _repository;
  MenuBloc(this._repository) : super(MenuBlocInitState()) {
    on<GetMenuListEvent>(
      (event, emit) async {
        await getMenuList(emit, event);
      },
      transformer: droppable(),
    );
    on<GetMenuDetailEvent>(
      (event, emit) async {
        await getMenuDetail(emit, event);
      },
      transformer: droppable(),
    );
    on<ClearMenuDetailEvent>(
      (event, emit) {
        clearDetail(emit, event);
      },
      transformer: sequential(),
    );
  }

  clearDetail(emit, MenuEvent event) {
    try {
      ClearMenuDetailEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  getMenuList(emit, MenuEvent event) async {
    try {
      await GetMenuListEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  getMenuDetail(emit, MenuEvent event) async {
    try {
      await GetMenuDetailEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  handleException(emit, error) {
    if (error is BlocException) {
      emit(MenuBlocErrorState(state.menus, state.detail, error));
      return;
    } else if (error is DioException) {
      final dioException = DIOEXCEPTION[error.type];
      if (dioException != null) {
        emit(MenuBlocErrorState(
          state.menus,
          state.detail,
          BlocException(
            dioException,
            ExceptionType.APIException,
          ),
        ));
      }
    } else {
      emit(
        MenuBlocErrorState(
          state.menus,
          state.detail,
          BlocException(
            error.toString(),
            ExceptionType.UnknownException,
          ),
        ),
      );
    }
  }
}
