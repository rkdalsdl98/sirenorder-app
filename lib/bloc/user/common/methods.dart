import 'package:sirenorder_app/model/user_model.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

OrderState convertNotifyState(String state) {
  switch (state) {
    case "wait":
      return OrderState.wait;
    case "refuse":
      return OrderState.refuse;
    case "accept":
      return OrderState.accept;
    case "finish":
      return OrderState.finish;
    default:
      throw BlocException(
        "주문현황을 받아오는데 실패했습니다.",
        ExceptionType.ServiceUnavailableException,
      );
  }
}
