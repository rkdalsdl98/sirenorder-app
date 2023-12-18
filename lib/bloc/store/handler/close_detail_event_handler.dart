import 'package:sirenorder_app/bloc/store/event/close_detail_event.dart';
import 'package:sirenorder_app/bloc/store/event/store_event.dart';
import 'package:sirenorder_app/bloc/store/handler/store_event_handler.dart';
import 'package:sirenorder_app/bloc/store/store_bloc_state.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class CloseDetailEventHandler extends StoreEventHandler {
  @override
  handleEvent(
    emit,
    StoreEvent event,
    StoreBlocState state,
  ) {
    if (event is! CloseDetailEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }
    emit(StoreBlocLoadingState(
      state.stores,
      state.storeDetail,
      state.selStore,
    ));
    emit(StoreBlocLoadedState(
      state.stores,
      null,
      state.selStore,
    ));
  }
}
