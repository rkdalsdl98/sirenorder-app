import 'package:sirenorder_app/bloc/menu/event/get_menu_list_event.dart';
import 'package:sirenorder_app/bloc/menu/event/menu_event.dart';
import 'package:sirenorder_app/bloc/menu/handler/menu_event_handler.dart';
import 'package:sirenorder_app/bloc/menu/menu_state.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/model/response_model.dart';
import 'package:sirenorder_app/respository/menu_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class GetMenuListEventHandler extends MenuEventHandler {
  @override
  handleEvent(
    emit,
    MenuEvent event,
    MenuBlocState state,
  ) async {
    if (event is! GetMenuListEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }
    emit(MenuBlocLoadingState(state.menus, state.detail));
    final res = await fetchGet(RequestRoute.menu);
    if (res.data['message'] != null) {
      final failed = FailedResponse.fromJson(res.data);
      throw BlocException(failed.message, ExceptionType.APIException);
    }

    final success = SuccessResponse<List<dynamic>>.fromJson(res.data);
    if (success.status != 200) {
      throw BlocException(
        "서버에서 해당 요청을 수행하지 못했습니다.",
        ExceptionType.ServiceUnavailableException,
      );
    }
    final menus = success.data.map((menu) => MenuModel.fromJson(menu)).toList();
    emit(MenuBlocLoadedState(menus, state.detail));
  }
}
