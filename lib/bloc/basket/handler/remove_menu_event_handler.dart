import 'package:sirenorder_app/bloc/basket/basket_bloc_state.dart';
import 'package:sirenorder_app/bloc/basket/event/basket_event.dart';
import 'package:sirenorder_app/bloc/basket/event/remove_menu_event.dart';
import 'package:sirenorder_app/bloc/basket/handler/basket_event_handler.dart';
import 'package:sirenorder_app/respository/basket_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class RemoveMenuEventHandler extends BasketEventHandler {
  @override
  handleEvent(
    emit,
    BasketEvent event,
    BasketBlocState state, {
    BasketRepository? repository,
  }) async {
    if (event is! RemoveMenuEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    } else if (repository == null) {
      throw BlocException(
        "저장소를 불러오는데 실패했습니다.",
        ExceptionType.RepsitoryNotDefinedException,
      );
    }
    emit(BasketBlocLoadingState(state.basket));
    state.basket.removeAt(event.index);
    final result = await repository.saveBasket(
      state.basket.map<Map<String, dynamic>>((item) => item.toJson()).toList(),
    );
    if (result) {
      emit(BasketBlocSuccessedActionState(state.basket));
    } else {
      throw BlocException(
        "메뉴를 삭제하는 것에 실패했습니다.",
        ExceptionType.UnknownException,
      );
    }
  }
}
