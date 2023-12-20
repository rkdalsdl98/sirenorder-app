import 'package:sirenorder_app/bloc/basket/basket_bloc_state.dart';
import 'package:sirenorder_app/bloc/basket/event/basket_event.dart';
import 'package:sirenorder_app/bloc/basket/handler/basket_event_handler.dart';

class ShowedErrorEventHandler extends BasketEventHandler {
  @override
  handleEvent(
    emit,
    BasketEvent event,
    BasketBlocState state,
  ) {
    emit(BasketBlocLoadedState(state.basket));
  }
}
