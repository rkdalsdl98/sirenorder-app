import 'package:sirenorder_app/bloc/store/event/get_store_detail_event.dart';
import 'package:sirenorder_app/bloc/store/event/store_event.dart';
import 'package:sirenorder_app/bloc/store/handler/store_event_handler.dart';
import 'package:sirenorder_app/bloc/store/store_bloc_state.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';
import 'package:sirenorder_app/model/response_model.dart';
import 'package:sirenorder_app/model/store_model.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class GetStoreDetailEventHandler extends StoreEventHandler {
  @override
  handleEvent(
    emit,
    StoreEvent event,
    StoreBlocState state,
  ) async {
    if (event is! GetStoreDetailEvent) {
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

    final res = await fetchGet(
      RequestRoute.storedetail,
      queryParams: {
        "detailId": event.detailid,
      },
    );
    if (res.data['message'] != null) {
      final failed = FailedResponse.fromJson(res.data);
      throw BlocException(failed.message, ExceptionType.APIException);
    }

    final success = SuccessResponse<dynamic>.fromJson(res.data);
    if (success.status != 200) {
      throw BlocException(
        "서버에서 해당 요청을 수행하지 못했습니다.",
        ExceptionType.ServiceUnavailableException,
      );
    }
    final detail = StoreDetailModel.fromJson(success.data);
    emit(StoreBlocShowDetailState(
      state.stores,
      detail,
      state.selStore,
    ));
  }
}
