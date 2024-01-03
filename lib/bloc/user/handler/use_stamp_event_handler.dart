import 'package:dio/dio.dart';
import 'package:sirenorder_app/bloc/user/event/use_stamp_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/bloc/user/handler/user_event_handler.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';
import 'package:sirenorder_app/model/response_model.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class UseStampEventHandler extends UserEventHandler {
  @override
  handleEvent(
    emit,
    UserEvent event,
    UserBlocState state, {
    UserRepository? repository,
  }) async {
    if (event is! UseStampEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }

    emit(UserBlocLoadingState(state.user));
    final res = await _sendRequest(state.user!.accesstoken!);
    if (res.data['message'] != null) {
      final failed = FailedResponse.fromJson(res.data);
      throw BlocException(failed.message, ExceptionType.APIException);
    }

    final success = SuccessResponse.fromJson(res.data);
    if (success.status != 201) {
      throw BlocException(
        "서버에서 해당 요청을 수행하지 못했습니다.",
        ExceptionType.ServiceUnavailableException,
      );
    }

    final coupon = CouponModel.fromJson(success.data);
    state.user!.coupons!.add(coupon.toJson());
    state.user!.wallet!.stars = 0;
    emit(UserBlocLoadedState(state.user));
  }

  Future<Response> _sendRequest(String token) async {
    return await fetchPost(
      RequestRoute.stamp,
      headers: {
        "authorization": "Bearer $token",
      },
    );
  }
}
