import 'package:sirenorder_app/bloc/user/event/user_event.dart';
import 'package:sirenorder_app/model/order_model.dart';
import 'package:sirenorder_app/model/user_model.dart';

class UseCouponEvent extends UserEvent {
  CouponModel coupon;
  String storeId;
  DeliveryInfo deliveryinfo;
  UseCouponEvent(this.coupon, this.deliveryinfo, this.storeId);
  @override
  List<Object?> get props => [storeId];
}
