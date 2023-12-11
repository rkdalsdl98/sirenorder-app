import 'package:dio/dio.dart';
import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/bloc/user/event/user_login_event.dart';
import 'package:sirenorder_app/bloc/user/handler/user_event_handler.dart';
import 'package:sirenorder_app/bloc/user/user_bloc_state.dart';
import 'package:sirenorder_app/datasource/api_manager.dart';
import 'package:sirenorder_app/model/response_model.dart';
import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class UserLoginEventHandler extends UserEventHandler {
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
    } else if (event is! UserLoginEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }

    emit(UserBlocLoadingState(state.user, state.orderState));
    final res = await _sendLoginRequest(event);
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

    final user = UserModel.fromJson(success.data);
    await repository.saveData("token", {"accesstoken": user.accesstoken});
    emit(UserBlocLoadedState(user, state.orderState));
  }

  LoginType _getLoginType(UserLoginEvent event) {
    if (event.tokenLogin != null) {
      return LoginType.tokenlogin;
    }

    return LoginType.typinglogin;
  }

  RequestRoute _getRoute(LoginType type) {
    switch (type) {
      case LoginType.tokenlogin:
        return RequestRoute.tokenlogin;
      case LoginType.typinglogin:
        return RequestRoute.login;
      default:
        throw BlocException(
          "올바른 요청이 아닙니다.",
          ExceptionType.APIException,
        );
    }
  }

  Future<Response> _sendLoginRequest(UserLoginEvent event) async {
    LoginType type = _getLoginType(event);
    RequestRoute route = _getRoute(type);

    switch (type) {
      case LoginType.tokenlogin:
        return await fetchPost(
          route,
          headers: {"authorization": event.tokenLogin},
        );
      case LoginType.typinglogin:
        return await fetchPost(route, queryParams: {
          "email": event.typingLogin!.email,
          "pass": event.typingLogin!.pass,
        });
      default:
        throw BlocException(
          "로그인 요청중 오류가 발생했습니다.",
          ExceptionType.APIException,
        );
    }
  }
}

enum LoginType {
  typinglogin,
  tokenlogin,
}
