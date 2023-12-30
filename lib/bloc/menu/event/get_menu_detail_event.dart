import 'package:sirenorder_app/bloc/menu/event/menu_event.dart';

class GetMenuDetailEvent extends MenuEvent {
  final int detailId;
  GetMenuDetailEvent(this.detailId);
  @override
  List<Object?> get props => [];
}
