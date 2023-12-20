import 'package:sirenorder_app/bloc/basket/basket_bloc_state.dart';
import 'package:sirenorder_app/bloc/basket/event/basket_event.dart';
import 'package:sirenorder_app/bloc/basket/event/put_menu_event.dart';
import 'package:sirenorder_app/bloc/basket/handler/basket_event_handler.dart';
import 'package:sirenorder_app/model/basket_item_model.dart';
import 'package:sirenorder_app/respository/basket_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class PutMenuEventHandler extends BasketEventHandler {
  @override
  handleEvent(
    emit,
    BasketEvent event,
    BasketBlocState state, {
    BasketRepository? repository,
  }) async {
    if (event is! PutMenuEvent) {
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
    final isDuplicated = checkForDuplicates(state.basket, event.item);
    if (isDuplicated) {
      throw BlocException(
        "이미 등록된 메뉴입니다.",
        ExceptionType.DuplicatedDataExcpetion,
      );
    }
    state.basket.add(event.item);
    final result = await repository.saveBasket(
      state.basket.map<Map<String, dynamic>>((item) => item.toJson()).toList(),
    );
    if (result) {
      emit(BasketBlocSuccessedActionState(state.basket));
    } else {
      throw BlocException(
        "메뉴를 담는 것에 실패했습니다.",
        ExceptionType.UnknownException,
      );
    }
  }

  bool checkForDuplicates(
    List<BasketItemModel> list,
    BasketItemModel item,
  ) {
    return !list.every((e) => e.menu.detailId != item.menu.detailId);
  }
}
