import 'package:sirenorder_app/bloc/menu/event/menu_event.dart';
import 'package:sirenorder_app/type/bloc/menu_type.dart';

class GetMenuListEvent extends MenuEvent {
  final MenuCategory? category;
  GetMenuListEvent(this.category);

  @override
  List<Object?> get props => [];
}
