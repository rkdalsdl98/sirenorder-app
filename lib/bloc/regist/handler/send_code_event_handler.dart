import 'package:sirenorder_app/bloc/regist/event/regist_event.dart';
import 'package:sirenorder_app/bloc/regist/event/send_code_event.dart';
import 'package:sirenorder_app/bloc/regist/handler/regist_event_handler.dart';
import 'package:sirenorder_app/bloc/regist/regist_bloc_state.dart';
import 'package:sirenorder_app/model/response_model.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

import '../../../datasource/api_manager.dart';

class SendCodeEventHandler extends RegistEventHandler {
  @override
  handleEvent(
    emit,
    RegistEvent event,
    RegistBlocState state, {
    UserRepository? repository,
  }) async {
    if (event is! SendCodeEvent) {
      throw BlocException(
        "올바른 요청이 아닙니다.",
        ExceptionType.StateException,
      );
    }

    emit(RegistBlocLoadingState(state.authEmail, state.pulishCode));
    final res = await fetchPost(
      event.route,
      queryParams: {"code": event.code},
    );

    if (res.data['message'] != null) {
      final failed = FailedResponse.fromJson(res.data);
      throw BlocException(failed.message, ExceptionType.APIException);
    }

    final success = SuccessResponse<bool>.fromJson(res.data);
    if (success.status != 201) {
      throw BlocException(
        "서버에서 해당 요청을 수행하지 못했습니다.",
        ExceptionType.ServiceUnavailableException,
      );
    }

    emit(RegistBlocLoadedState(success.data, state.pulishCode));
  }
}
