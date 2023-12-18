import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/order/event/clear_basket_event.dart';
import 'package:sirenorder_app/bloc/order/event/clear_data_event.dart';
import 'package:sirenorder_app/bloc/order/event/order_event.dart';
import 'package:sirenorder_app/bloc/order/event/put_menu_event.dart';
import 'package:sirenorder_app/bloc/order/event/remove_menu_event.dart';
import 'package:sirenorder_app/bloc/order/event/upsert_data_event.dart';
import 'package:sirenorder_app/bloc/order/handler/clear_basket_event_handler.dart';
import 'package:sirenorder_app/bloc/order/handler/clear_data_event_handler.dart';
import 'package:sirenorder_app/bloc/order/handler/pui_menu_event_handler.dart';
import 'package:sirenorder_app/bloc/order/handler/remove_menu_event_handler.dart';
import 'package:sirenorder_app/bloc/order/handler/upsert_data_event_handler.dart';
import 'package:sirenorder_app/bloc/order/order_bloc_state.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class OrderBloc extends Bloc<OrderEvent, OrderBlocState> {
  OrderBloc() : super(OrderBlocInitState()) {
    on<ClearDataEvent>(
      (event, emit) {
        clearData(emit, event);
      },
      transformer: droppable(),
    );
    on<UpsertDataEvent>(
      (event, emit) {
        upsertData(emit, event);
      },
      transformer: sequential(),
    );
    on<PutMenuEvent>(
      (event, emit) {
        putMenu(emit, event);
      },
      transformer: droppable(),
    );
    on<RemoveMenuEvent>(
      (event, emit) {
        removeMenu(emit, event);
      },
      transformer: droppable(),
    );
    on<ClearBasketEvent>(
      (event, emit) {
        clearBasket(emit, event);
      },
      transformer: droppable(),
    );
  }

  putMenu(emit, OrderEvent event) {
    try {
      PutMenuEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  removeMenu(emit, OrderEvent event) {
    try {
      RemoveMenuEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  clearBasket(emit, OrderEvent event) {
    try {
      ClearBasketEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  upsertData(emit, OrderEvent event) {
    try {
      UpsertDataEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  clearData(emit, OrderEvent event) {
    try {
      ClearDataEventHandler().handleEvent(
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
      emit(OrderBlocErrorState(
        state.data,
        state.basket,
        error,
      ));
      return;
    } else if (error is DioException) {
      final dioException = DIOEXCEPTION[error.type];
      if (dioException != null) {
        emit(OrderBlocErrorState(
          state.data,
          state.basket,
          BlocException(
            dioException,
            ExceptionType.APIException,
          ),
        ));
      }
    } else {
      emit(
        OrderBlocErrorState(
          state.data,
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
