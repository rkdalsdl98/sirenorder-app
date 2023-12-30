import 'package:sirenorder_app/bloc/order/event/order_event.dart';
import 'package:sirenorder_app/bloc/order/event/upsert_data_event.dart';
import 'package:sirenorder_app/bloc/order/handler/order_event_handler.dart';
import 'package:sirenorder_app/bloc/order/order_bloc_state.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class UpsertDataEventHandler extends OrderEventHandler {
  @override
  handleEvent(
    emit,
    OrderEvent event,
    OrderBlocState state,
  ) {
    if (event is! UpsertDataEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }
    state.data[event.key] = event.data;
    emit(OrderBlocLoadedState(state.data, state.basket));
  }
}
