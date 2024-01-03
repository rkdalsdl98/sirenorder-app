import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/order_model.dart';

class BasketItemModel extends Equatable {
  final DeliveryInfo deliveryInfo;
  final MenuModel menu;
  const BasketItemModel(this.deliveryInfo, this.menu);

  BasketItemModel.fromJson(Map<String, dynamic> json)
      : deliveryInfo = DeliveryInfo.fromJson(json['deliveryinfo']),
        menu = MenuModel.fromJson(json['menu']);
  Map<String, dynamic> toJson() => {
        "deliveryinfo": deliveryInfo.toJson(),
        "menu": menu.toJson(),
      };

  @override
  List<Object?> get props => [menu];
}
