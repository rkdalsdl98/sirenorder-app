import 'package:sirenorder_app/bloc/store/event/store_event.dart';

class GetStoreDetailEvent extends StoreEvent {
  final int detailid;
  GetStoreDetailEvent(this.detailid);
  @override
  List<Object?> get props => [];
}
