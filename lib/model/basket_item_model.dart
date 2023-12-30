import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/order_model.dart';

class BasketItemModel extends Equatable {
  final DeliveryInfo deliveryInfo;
  final MenuModel menu;
  final int price;
  const BasketItemModel(this.deliveryInfo, this.menu, this.price);

  BasketItemModel.fromJson(Map<String, dynamic> json)
      : deliveryInfo = DeliveryInfo.fromJson(json['deliveryinfo']),
        menu = MenuModel.fromJson(json['menu']),
        price = json['price'];
  Map<String, dynamic> toJson() => {
        "deliveryinfo": deliveryInfo.toJson(),
        "menu": menu.toJson(),
        "price": price,
      };

  @override
  List<Object?> get props => [menu];
}
