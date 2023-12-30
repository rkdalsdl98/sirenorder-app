import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/order_model.dart';

class UserModel extends Equatable {
  String? email, tel, nickname, accesstoken, createdAt, updatedAt;
  List<dynamic>? coupons;
  Wallet? wallet;
  List<GiftModel>? gifts;
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
        gifts!.add(GiftModel.fromJson(gift));
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

class GiftModel extends Equatable {
  String? uuid, to, from, wrappingtype, message;
  CouponModel? coupon;
  bool? used;

  GiftModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    to = json['to'];
    from = json['to'];
    used = json['used'];
    message = json['message'];
    wrappingtype = json['wrappingtype'];

    if (json['coupon'] != null) {
      coupon = CouponModel.fromJson(json['coupon']);
    }
  }
  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "coupon": coupon?.toJson(),
        "to": to,
        "from": from,
        "message": message,
        "used": used,
        "wrappingtype": wrappingtype,
      };

  @override
  List<Object?> get props => [uuid, coupon];
}

class OrderHistory extends Equatable {
  String? impUid, storeId, storeName, storeThumbnail, orderedAt;
  int? saleprice, totalprice;
  List<DeliveryInfo>? deliveryinfos;
  List<MenuInfo>? menus;

  OrderHistory.fromJson(Map<String, dynamic> json) {
    impUid = json['imp_uid'];
    storeId = json['store_uid'];
    storeName = json['store_name'];
    storeThumbnail = json['store_thumbnail'];
    saleprice = json['saleprice'];
    totalprice = json['totalprice'];
    orderedAt = json['order_date'];
    deliveryinfos = [];
    if (json['deliveryinfo'] != null) {
      for (var info in json['deliveryinfo']) {
        deliveryinfos!.add(DeliveryInfo.fromJson(info));
      }
    }

    menus = [];
    if (json['menus'] != null) {
      for (var menu in json['menus']) {
        menus!.add(MenuInfo.fromJson(menu));
      }
    }
  }

  Map<String, dynamic> toJson() => {
        "imp_uid": impUid,
        "store_name": storeName,
        "store_thumbnail": storeThumbnail,
        "store_uid": storeId,
        "saleprice": saleprice,
        "totalprice": totalprice,
        "order_date": orderedAt,
        "deliveryinfo": deliveryinfos!.map<dynamic>((item) => item.toJson()),
        "menus": menus!.map((menu) => menu.toJson()),
      };

  @override
  List<Object?> get props => [
        menus?.length,
        deliveryinfos?.length,
        totalprice,
        saleprice,
        storeId,
        impUid,
        orderedAt,
      ];
}

class MenuInfo {
  String? name, thumbnail, en_name;
  int? price, count;

  MenuInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    thumbnail = json['thumbnail'];
    en_name = json['en_name'];
    price = json['price'];
    count = json['count'];
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "en_name": en_name,
        "thumbnail": thumbnail,
        "price": price,
        "count": count,
      };
}

class CouponModel {
  final String code, menu_name;
  final DateTime expirationPeriod;
  String? thumbnail;

  CouponModel.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        menu_name = json['menu_name'],
        expirationPeriod = DateTime.parse(json['expiration_period']),
        thumbnail = json['thumbnail'];

  Map<String, dynamic> toJson() => {
        "code": code,
        "menu_name": menu_name,
        "expiration_period": expirationPeriod.toString(),
        "thumbnail": thumbnail,
      };
}

enum OrderState {
  wait,
  refuse,
  accept,
  finish,
}
