import 'package:sirenorder_app/bloc/basket/basket_bloc_state.dart';
import 'package:sirenorder_app/bloc/basket/event/basket_event.dart';
import 'package:sirenorder_app/bloc/basket/event/initialize_event.dart';
import 'package:sirenorder_app/bloc/basket/handler/basket_event_handler.dart';
import 'package:sirenorder_app/model/basket_item_model.dart';
import 'package:sirenorder_app/respository/basket_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class InitializeEventHandler extends BasketEventHandler {
  @override
  handleEvent(
    emit,
    BasketEvent event,
    BasketBlocState state, {
    BasketRepository? repository,
  }) async {
    if (event is! InitializeEvent) {
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
    emit(BasketBlocLoadingState(
      state.basket,
    ));
    await Future.delayed(const Duration(milliseconds: 1000)).then((_) async {
      var list = await repository.getBasketItems();
      if (list != null) {
        final basket = list
            .map<BasketItemModel>((json) => BasketItemModel.fromJson(json))
            .toList();
        emit(
          BasketBlocLoadedState(basket),
        );
      } else {
        BasketBlocLoadedState(state.basket);
      }
    });
  }
}
