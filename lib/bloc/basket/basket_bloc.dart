import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:sirenorder_app/bloc/basket/basket_bloc_state.dart';
import 'package:sirenorder_app/bloc/basket/event/basket_event.dart';
import 'package:sirenorder_app/bloc/basket/event/clear_basket_event.dart';
import 'package:sirenorder_app/bloc/basket/event/initialize_event.dart';
import 'package:sirenorder_app/bloc/basket/event/put_menu_event.dart';
import 'package:sirenorder_app/bloc/basket/event/remove_menu_event.dart';
import 'package:sirenorder_app/bloc/basket/event/showed_error_event.dart';
import 'package:sirenorder_app/bloc/basket/event/update_item_event.dart';
import 'package:sirenorder_app/bloc/basket/handler/clear_basket_event_handler.dart';
import 'package:sirenorder_app/bloc/basket/handler/initialize_event_handler.dart';
import 'package:sirenorder_app/bloc/basket/handler/put_menu_event_handler.dart';
import 'package:sirenorder_app/bloc/basket/handler/remove_menu_event_handler.dart';
import 'package:sirenorder_app/bloc/basket/handler/showed_error_event_handler.dart';
import 'package:sirenorder_app/bloc/basket/handler/update_item_event_handler.dart';
import 'package:sirenorder_app/respository/basket_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class BasketBloc extends Bloc<BasketEvent, BasketBlocState> {
  final BasketRepository _repository;
  BasketBloc(this._repository) : super(BasketBlocInitState()) {
    on<InitializeEvent>(
      (event, emit) async {
        await initialized(emit, event);
      },
      transformer: droppable(),
    );
    on<PutMenuEvent>(
      (event, emit) async {
        await putMenu(emit, event);
      },
      transformer: droppable(),
    );
    on<RemoveMenuEvent>(
      (event, emit) async {
        await removeMenu(emit, event);
      },
      transformer: droppable(),
    );
    on<ClearBasketEvent>(
      (event, emit) async {
        await clearBasket(emit, event);
      },
      transformer: droppable(),
    );
    on<ShowedErrorEvent>(
      (event, emit) {
        ShowedErrorEventHandler().handleEvent(emit, event, state);
      },
      transformer: sequential(),
    );
    on<UpdateItemEvent>(
      (event, emit) async {
        await updateItem(emit, event);
      },
      transformer: sequential(),
    );

    add(InitializeEvent());
  }

  updateItem(emit, BasketEvent event) async {
    try {
      await UpdateItemEventHandler().handleEvent(
        emit,
        event,
        state,
        repository: _repository,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  putMenu(emit, BasketEvent event) async {
    try {
      await PutMenuEventHandler().handleEvent(
        emit,
        event,
        state,
        repository: _repository,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  removeMenu(emit, BasketEvent event) async {
    try {
      await RemoveMenuEventHandler().handleEvent(
        emit,
        event,
        state,
        repository: _repository,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  clearBasket(emit, BasketEvent event) async {
    try {
      await ClearBasketEventHandler().handleEvent(
        emit,
        event,
        state,
        repository: _repository,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  initialized(emit, BasketEvent event) async {
    try {
      await InitializeEventHandler().handleEvent(
        emit,
        event,
        state,
        repository: _repository,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  handleException(emit, error) {
    print(error);
    if (error is BlocException) {
      emit(BasketBlocErrorState(state.basket, error));
      return;
    } else if (error is DioException) {
      final dioException = DIOEXCEPTION[error.type];
      if (dioException != null) {
        emit(BasketBlocErrorState(
          state.basket,
          BlocException(
            dioException,
            ExceptionType.APIException,
          ),
        ));
      }
    } else {
      emit(
        BasketBlocErrorState(
          state.basket,
          BlocException(
            error.toString(),
            ExceptionType.UnknownException,
          ),
        ),
      );
    }
  }
}
