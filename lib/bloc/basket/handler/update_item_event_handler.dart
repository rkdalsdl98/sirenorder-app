import 'package:sirenorder_app/bloc/basket/basket_bloc_state.dart';
import 'package:sirenorder_app/bloc/basket/event/basket_event.dart';
import 'package:sirenorder_app/bloc/basket/event/update_item_event.dart';
import 'package:sirenorder_app/bloc/basket/handler/basket_event_handler.dart';
import 'package:sirenorder_app/respository/basket_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class UpdateItemEventHandler extends BasketEventHandler {
  @override
  handleEvent(
    emit,
    BasketEvent event,
    BasketBlocState state, {
    BasketRepository? repository,
  }) async {
    if (event is! UpdateItemEvent) {
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
    final List<Map<String, dynamic>> savedBasket = [];
    final updatedBasket = state.basket.map((item) {
      if (event.index == 0) {
        --event.index;
        savedBasket.add(event.item.toJson());
        return event.item;
      }
      --event.index;
      savedBasket.add(item.toJson());
      return item;
    }).toList();
    await repository.saveBasket(savedBasket);
    emit(BasketBlocSuccessedActionState(updatedBasket));
  }
}
