import 'package:dio/dio.dart';
import 'package:sirenorder_app/bloc/user/event/register_coupon_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/bloc/user/handler/user_event_handler.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';
import 'package:sirenorder_app/model/response_model.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class RegisterCouponEventHandler extends UserEventHandler {
  @override
  handleEvent(
    emit,
    UserEvent event,
    UserBlocState state, {
    UserRepository? repository,
  }) async {
    if (repository == null) {
      throw BlocException(
        "저장소 초기화에 실패했습니다.",
        ExceptionType.RepsitoryNotDefinedException,
      );
    } else if (event is! RegisterCouponEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }

    emit(UserBlocLoadingState(state.user));
    final res = await _sendRegisterRequest(event);
    if (res.data['message'] != null) {
      final failed = FailedResponse.fromJson(res.data);
      if (failed.substatus == "ExpiredCoupon") {
        throw BlocException("사용기한이 만료된 쿠폰입니다.", ExceptionType.APIException);
      } else if (failed.status == 204) {
        throw BlocException("쿠폰을 찾을 수 없습니다.", ExceptionType.APIException);
      }
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
    emit(UserBlocLoadedState(state.user));
  }

  Future<Response> _sendRegisterRequest(RegisterCouponEvent event) async {
    return await fetchPost(
      RequestRoute.couponregister,
      queryParams: {
        "user_email": event.userEmail,
        "code": event.code,
      },
    );
  }
}
