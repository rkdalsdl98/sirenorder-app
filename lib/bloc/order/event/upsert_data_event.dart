import 'package:sirenorder_app/bloc/order/event/order_event.dart';

class UpsertDataEvent extends OrderEvent {
  final String key;
  final dynamic data;
  UpsertDataEvent(this.key, this.data);
  @override
  List<Object?> get props => [key, data];
}
