import 'package:sirenorder_app/bloc/store/event/store_event.dart';
import 'package:sirenorder_app/model/store_model.dart';

class SelectStoreEvent extends StoreEvent {
  final StoreModel store;
  SelectStoreEvent(this.store);
  @override
  List<Object?> get props => [];
}
