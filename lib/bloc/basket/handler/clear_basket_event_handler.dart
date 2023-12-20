import 'package:sirenorder_app/bloc/basket/basket_bloc_state.dart';
import 'package:sirenorder_app/bloc/basket/event/basket_event.dart';
import 'package:sirenorder_app/bloc/basket/event/clear_basket_event.dart';
import 'package:sirenorder_app/bloc/basket/handler/basket_event_handler.dart';
import 'package:sirenorder_app/respository/basket_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class ClearBasketEventHandler extends BasketEventHandler {
  @override
  handleEvent(
    emit,
    BasketEvent event,
    BasketBlocState state, {
    BasketRepository? repository,
  }) async {
    if (event is! ClearBasketEvent) {
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
    final result = await repository.clearBasket();
    if (result) {
      state.basket.clear();
      emit(BasketBlocSuccessedActionState(state.basket));
    } else {
      throw BlocException(
        "메뉴를 담는 것에 실패했습니다.",
        ExceptionType.UnknownException,
      );
    }
  }
}
