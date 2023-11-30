import 'package:sirenorder_app/bloc/user/common/methods.dart' as NotifyMethods;
import 'package:sirenorder_app/bloc/user/event/alert_notify_event.dart';
import 'package:sirenorder_app/bloc/user/event/listen_notify_order_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/bloc/user/handler/user_event_handler.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';
import 'package:sirenorder_app/model/response_model.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class ListenNotifyOrderEventEventHandler extends UserEventHandler {
  var count = 0;

  @override
  handleEvent(
    emit,
    UserEvent event,
    UserBlocState state, {
    UserRepository? repository,
    UserBloc? bloc,
  }) async {
    if (event is! ListenNotifyOrderEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.APIException,
      );
    } else if (bloc == null) {
      throw BlocException(
        "오류",
        ExceptionType.APIException,
      );
    }
    state.listenOrderState(
      () => _bindOrderState(
        bloc,
        state,
        event.orderId,
      ),
    );
  }

  Future<void> _bindOrderState(
    UserBloc bloc,
    UserBlocState state,
    String orderId,
  ) async {
    final response = await fetchGet(
      RequestRoute.orderstate,
      queryParams: {
        "order_uid": orderId,
      },
    );
    if (response.data['message'] != null) {
      final failed = FailedResponse.fromJson(response.data);
      throw BlocException(failed.message, ExceptionType.APIException);
    }

    final success = SuccessResponse<String>.fromJson(response.data);
    if (success.status != 200) {
      throw BlocException(
        "서버에서 해당 요청을 수행하지 못했습니다.",
        ExceptionType.ServiceUnavailableException,
      );
    }
    final orderState = NotifyMethods.convertNotifyState(success.data);
    bloc.add(AlertNotifyEvent(orderState));
  }
}
