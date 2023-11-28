import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String? email, tel, nickname, accesstoken, createdAt, updatedAt;
  List<dynamic>? coupons;
  Wallet? wallet;
  List<Gift>? gifts;
  List<OrderHistory>? orderhistory;

  UserModel.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    email = json['email'];
    tel = json['tel'];
    accesstoken = json['accesstoken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    coupons = json['coupons'] ?? [];

    if (json['wallet'] != null) {
      wallet = Wallet.fromJson(json['wallet']);
    }

    gifts = [];
    if (json['gifts'] != null && (json['gifts'] as List<dynamic>).isNotEmpty) {
      for (var gift in (json['gifts'] as List<dynamic>)) {
        gifts!.add(Gift.fromJson(gift));
      }
    }

    orderhistory = [];
    if (json['orderhistory'] != null &&
        (json['orderhistory'] as List<dynamic>).isNotEmpty) {
      for (var history in (json['orderhistory'] as List<dynamic>)) {
        orderhistory!.add(OrderHistory.fromJson(history));
      }
    }
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "nickname": nickname,
        "tel": tel,
        "accesstoken": accesstoken,
        "coupons": coupons,
        "wallet": wallet?.toJson(),
        "gifts": gifts!.map((gift) => gift.toJson()),
        "orderhistory": orderhistory!.map((history) => history.toJson())
      };

  @override
  List<Object?> get props => [accesstoken, wallet];
}

class Wallet {
  String? uuid;
  int? point, stars;

  Wallet.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        point = json['point'],
        stars = json['stars'];
  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "point": point,
        "stars": stars,
      };
}

class Gift extends Equatable {
  String? uuid, coupon, to, from, wrappingtype;

  Gift.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        coupon = json['coupon'],
        to = json['to'],
        from = json['to'],
        wrappingtype = json['wrappingtype'];
  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "coupon": coupon,
        "to": to,
        "from": from,
        "wrappingtype": wrappingtype,
      };

  @override
  List<Object?> get props => [uuid, coupon];
}

class OrderHistory extends Equatable {
  String? uuid, storeId;
  int? saleprice, totalprice;
  DeliveryInfo? deliveryinfo;
  List<MenuInfo>? menus;

  OrderHistory.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    storeId = json['store_uid'];
    saleprice = json['saleprice'];
    totalprice = json['totalprice'];
    if (json['deliveryinfo'] != null) {
      deliveryinfo = DeliveryInfo.fromJson(json['deliveryinfo']);
    }

    menus = [];
    if (json['menus'] != null &&
        (json['menus'] as List<Map<String, dynamic>>).isNotEmpty) {
      for (var menu in (json['menus'] as List<Map<String, dynamic>>)) {
        menus!.add(MenuInfo.fromJson(menu));
      }
    }
  }

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "store_uid": storeId,
        "saleprice": saleprice,
        "totalprice": totalprice,
        "deliveryinfo": deliveryinfo?.toJson(),
        "menus": menus!.map((menu) => menu.toJson()),
      };

  @override
  List<Object?> get props => [];
}

class DeliveryInfo {
  String? memo, paymenttype;
  bool? take;

  DeliveryInfo.fromJson(Map<String, dynamic> json)
      : memo = json['memo'],
        paymenttype = json['paymenttype'],
        take = json['take'];
  Map<String, dynamic> toJson() => {
        "memo": memo,
        "paymenttype": paymenttype,
        "take": take,
      };
}

class MenuInfo {
  String? name, thumbnail, size, bottle, tempture;
  int? price, count;

  MenuInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        thumbnail = json['thumbnail'],
        size = json['size'],
        bottle = json['bottle'],
        tempture = json['tempture'],
        price = json['price'],
        count = json['count'];
  Map<String, dynamic> toJson() => {
        "name": name,
        "thumbnail": thumbnail,
        "size": size,
        "bottle": bottle,
        "tempture": tempture,
        "price": price,
        "count": count,
      };
}

enum OrderState {
  wait,
  refuse,
  accept,
  finish,
}
