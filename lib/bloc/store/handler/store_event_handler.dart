import 'package:sirenorder_app/bloc/store/event/store_event.dart';
import 'package:sirenorder_app/bloc/store/store_bloc_state.dart';

abstract class StoreEventHandler {
  handleEvent(
    emit,
    StoreEvent event,
    StoreBlocState state,
  ) {}
}
