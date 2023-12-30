import 'dart:convert';

import 'package:sirenorder_app/model/order_model.dart';

enum OrderState {
  wait,
  refuse,
  accept,
  finish,
}

enum OrderType {
  order,
  gift,
}

class PaymentCustomData {
  late final String type;
  late final dynamic data;

  PaymentCustomData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    switch (type) {
      case "order":
        data = OrderCustomData.fromJson(json['data']);
        break;
      case "gift":
        data = GiftCustomData.fromJson(json['data']);
        break;
      default:
        throw Error();
    }
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data.toJson(),
      };
}

class OrderCustomData {
  late final String storeId;
  late final OrderInfo info;

  OrderCustomData(
    this.storeId,
    this.info,
  );
  OrderCustomData.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    info = OrderInfo.fromJson(json['orderInfo']);
  }

  Map<String, dynamic> toJson() => {
        "storeId": storeId,
        "orderInfo": info.toJson(),
      };
}

class OrderInfo {
  late final List<dynamic> menus;
  late final List<dynamic> deliveryInfos;

  OrderInfo(
    this.deliveryInfos,
    this.menus,
  );
  OrderInfo.fromJson(Map<String, dynamic> json) {
    menus = [];
    deliveryInfos = [];
    if (json['deliveryinfo'] != null) {
      for (var info in json['deliveryinfo']) {
        deliveryInfos.add(info);
      }
    }

    if (json['menus'] != null) {
      for (var menu in json['menus']) {
        menus.add(menu);
      }
    }
  }

  Map<String, dynamic> toJson() => {
        "menus": menus,
        "deliveryinfo": deliveryInfos,
      };
}

class GiftCustomData {
  late final GiftInfo info;

  GiftCustomData(this.info);
  GiftCustomData.fromJson(Map<String, dynamic> json)
      : info = GiftInfo.fromJson(json['giftInfo']);

  Map<String, dynamic> toJson() => {
        "giftInfo": info.toJson(),
      };
}

class GiftInfo {
  late final String from, to, wrappingtype;
  late final MenuModel menu;
  String? message;

  GiftInfo(
    this.from,
    this.to,
    this.wrappingtype,
    this.menu,
    this.message,
  );
  GiftInfo.fromJson(Map<String, dynamic> json)
      : from = json['from'],
        to = json['to'],
        wrappingtype = json['wrappingtype'],
        message = json['message'],
        menu = json['menu'];

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
        "wrappingtype": wrappingtype,
        "menu": menu,
      };
}
