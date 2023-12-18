import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirenorder_app/bloc/store/event/close_detail_event.dart';
import 'package:sirenorder_app/bloc/store/event/get_store_detail_event.dart';
import 'package:sirenorder_app/bloc/store/event/get_stores_event.dart';
import 'package:sirenorder_app/bloc/store/event/select_store_event.dart';
import 'package:sirenorder_app/bloc/store/event/store_event.dart';
import 'package:sirenorder_app/bloc/store/handler/close_detail_event_handler.dart';
import 'package:sirenorder_app/bloc/store/handler/get_store_detail_event_handler.dart';
import 'package:sirenorder_app/bloc/store/handler/get_stores_event_handler.dart';
import 'package:sirenorder_app/bloc/store/handler/select_store_event_handler.dart';
import 'package:sirenorder_app/bloc/store/store_bloc_state.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class StoreBloc extends Bloc<StoreEvent, StoreBlocState> {
  StoreBloc() : super(StoreBlocInitState()) {
    on<GetStoresEvent>(
      (event, emit) async {
        await getStores(emit, event);
      },
      transformer: droppable(),
    );
    on<GetStoreDetailEvent>(
      (event, emit) async {
        await getStoreDetail(emit, event);
      },
      transformer: droppable(),
    );
    on<CloseDetailEvent>(
      (event, emit) {
        closeDetail(emit, event);
      },
      transformer: droppable(),
    );
    on<SelectStoreEvent>((event, emit) {
      selectStore(emit, event);
    });

    add(GetStoresEvent());
  }

  selectStore(emit, StoreEvent event) {
    try {
      SelectStoreEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  closeDetail(emit, StoreEvent event) {
    try {
      CloseDetailEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  getStores(emit, StoreEvent event) async {
    try {
      await GetStoresEventHandler().handleEvent(
        emit,
        event,
        state,
      );
    } catch (e) {
      handleException(emit, e);
    }
  }

  getStoreDetail(emit, StoreEvent event) async {
    try {
      await GetStoreDetailEventHandler().handleEvent(
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
      emit(StoreBlocErrorState(
        state.stores,
        state.storeDetail,
        state.selStore,
        error,
      ));
      return;
    } else if (error is DioException) {
      final dioException = DIOEXCEPTION[error.type];
      if (dioException != null) {
        emit(StoreBlocErrorState(
          state.stores,
          state.storeDetail,
          state.selStore,
          BlocException(
            dioException,
            ExceptionType.APIException,
          ),
        ));
      }
    } else {
      emit(
        StoreBlocErrorState(
          state.stores,
          state.storeDetail,
          state.selStore,
          BlocException(
            error.toString(),
            ExceptionType.UnknownException,
          ),
        ),
      );
    }
  }
}
