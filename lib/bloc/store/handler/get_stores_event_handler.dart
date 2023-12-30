import 'package:sirenorder_app/bloc/store/event/get_stores_event.dart';
import 'package:sirenorder_app/bloc/store/event/store_event.dart';
import 'package:sirenorder_app/bloc/store/handler/store_event_handler.dart';
import 'package:sirenorder_app/bloc/store/store_bloc_state.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';
import 'package:sirenorder_app/model/response_model.dart';
import 'package:sirenorder_app/model/store_model.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class GetStoresEventHandler extends StoreEventHandler {
  @override
  handleEvent(
    emit,
    StoreEvent event,
    StoreBlocState state,
  ) async {
    if (event is! GetStoresEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }
    emit(StoreBlocLoadingState(
      state.stores,
      state.storeDetail,
      state.selStore,
    ));

    final res = await fetchGet(RequestRoute.store);
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
    final stores =
        success.data.map((store) => StoreModel.fromJson(store)).toList();
    emit(StoreBlocLoadedState(
      stores,
      state.storeDetail,
      state.selStore,
    ));
  }
}
