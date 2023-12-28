import 'package:dio/dio.dart';
import 'package:sirenorder_app/bloc/user/event/use_coupon_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/bloc/user/handler/user_event_handler.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';
import 'package:sirenorder_app/model/response_model.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class UseCouponEventHandler extends UserEventHandler {
  @override
  handleEvent(
    emit,
    UserEvent event,
    UserBlocState state, {
    UserRepository? repository,
  }) async {
    if (event is! UseCouponEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }
    emit(UserBlocLoadingState(state.user));
    final res = await _useCoupon(event, state.user!.email!);
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

    final data = success.data as Map<String, dynamic>;
    bool result = data['result'] as bool;
    String? message = data['message'];
    if (!result) {
      emit(UserBlocLoadedState(state.user));
      throw BlocException(
        message!,
        ExceptionType.APIException,
      );
    }
    state.user!.coupons!
        .removeWhere((coupon) => coupon["code"] == event.coupon.code);
    emit(UserBlocLoadedState(state.user));
  }

  Future<Response> _useCoupon(
    UseCouponEvent event,
    String email,
  ) async {
    return await fetchPost(
      RequestRoute.usecoupon,
      body: {
        "user_email": email,
        "code": event.coupon.code,
        "storeId": event.storeId,
        "deliveryinfo": event.deliveryinfo,
      },
    );
  }
}
