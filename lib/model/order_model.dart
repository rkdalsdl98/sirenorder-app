import 'dart:convert';

import 'package:sirenorder_app/type/bloc/menu_type.dart';
import 'package:sirenorder_app/type/order_state.dart';

class OrderModel {
  late String buyerName, buyerEmail, buyerTel, name;
  late PaymentCustomData? customData;
  late final int amount;

  OrderModel(
    this.name,
    this.buyerTel,
    this.buyerEmail,
    this.buyerName,
    this.customData,
    this.amount,
  );

  OrderModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    buyerTel = json['buyer_tel'];
    buyerEmail = json['buyer_email'];
    buyerName = json['buyer_name'];
    amount = json['amount'];

    if (json['custom_data'] != null) {
      customData = PaymentCustomData.fromJson(json['custom_data']);
    } else {
      customData = null;
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "buyer_tel": buyerTel,
        "buyer_email": buyerEmail,
        "buyer_name": buyerName,
        "amount": amount,
        "custom_data": customData?.toJson(),
      };
}

class DeliveryInfo {
  late String memo, paymenttype;
  late bool take;

  DeliveryInfo(
    this.memo,
    this.paymenttype,
    this.take,
  );

  DeliveryInfo.fromJson(Map<String, dynamic> json)
      : memo = json['memo'],
        take = json['take'],
        paymenttype = json['paymenttype'];

  Map<String, dynamic> toJson() => {
        "memo": memo,
        "take": take,
        "paymenttype": paymenttype,
      };
}

class MenuModel {
  late String name, en_name, thumbnail;
  late int price, detailId;
  late MenuCategory category;
  int count = 1;

  MenuModel(
    this.category,
    this.count,
    this.name,
    this.en_name,
    this.thumbnail,
    this.price,
    this.detailId,
  );

  MenuModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    en_name = json['en_name'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    category = convertCategory(json['category']);
    detailId = json['detailId'];
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
        "category": category.name,
        "en_name": en_name,
        "thumbnail": thumbnail,
        "price": price,
        "detailId": detailId,
      };

  MenuCategory convertCategory(dynamic data) {
    switch (data) {
      case "drink":
        return MenuCategory.drink;
      case "food":
        return MenuCategory.food;
      case "product":
        return MenuCategory.product;
      default:
        return MenuCategory.notdefined;
    }
  }
}

class MenuDetailModel {
  String? description;
  late List<dynamic> allergys, nutritions;
  late int id;

  MenuDetailModel(
    this.description,
    this.allergys,
    this.nutritions,
    this.id,
  );

  MenuDetailModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    allergys = [];
    nutritions = [];

    if (json['allergys'] != null) {
      for (var allergy in json['allergys']) {
        allergys.add(allergy);
      }
    }

    if (json['nutritions'] != null) {
      for (var nutrition in json['nutritions']) {
        nutritions.add(NutritionsModel.fromJson(nutrition));
      }
    }
  }
}

class NutritionsModel {
  String size,
      calorie,
      carbohydrate,
      sugars,
      salt,
      protein,
      fat,
      cholesterol,
      transfat,
      saturatedfat,
      caffeine;

  NutritionsModel(
    this.salt,
    this.saturatedfat,
    this.size,
    this.caffeine,
    this.sugars,
    this.calorie,
    this.carbohydrate,
    this.cholesterol,
    this.fat,
    this.protein,
    this.transfat,
  );

  NutritionsModel.fromJson(Map<String, dynamic> json)
      : salt = json['salt'],
        size = json['size'],
        carbohydrate = json['carbohydrate'],
        caffeine = json['caffeine'],
        calorie = json['calorie'],
        sugars = json['sugars'],
        protein = json['protein'],
        fat = json['fat'],
        cholesterol = json['cholesterol'],
        transfat = json['transfat'],
        saturatedfat = json['saturatedfat'];

  Map<String, dynamic> toJson() => {
        "salt": salt,
        "size": size,
        "carbohydrate": carbohydrate,
        "caffeine": caffeine,
        "calorie": calorie,
        "sugars": sugars,
        "protein": protein,
        "fat": fat,
        "cholesterol": cholesterol,
        "transfat": transfat,
        "saturatedfat": saturatedfat,
      };
}
