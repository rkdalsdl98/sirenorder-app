import 'package:sirenorder_app/bloc/order/event/clear_data_event.dart';
import 'package:sirenorder_app/bloc/order/event/order_event.dart';
import 'package:sirenorder_app/bloc/order/handler/order_event_handler.dart';
import 'package:sirenorder_app/bloc/order/order_bloc_state.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class ClearDataEventHandler extends OrderEventHandler {
  @override
  handleEvent(
    emit,
    OrderEvent event,
    OrderBlocState state,
  ) {
    if (event is! ClearDataEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }
    state.data.removeWhere((key, value) => key != "take");
    emit(OrderBlocLoadedState(state.data, state.basket));
  }
}
