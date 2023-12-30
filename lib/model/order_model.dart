import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/type/bloc/menu_type.dart';
import 'package:sirenorder_app/type/order_state.dart';

class OrderModel {
  late String buyerName, buyerEmail, buyerTel, menuname;
  PaymentCustomData? customData;
  late final int amount;

  OrderModel({
    required String menuname,
    required String buyerTel,
    required String buyerEmail,
    required String buyerName,
    PaymentCustomData? customData,
    required int amount,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    menuname = json['name'];
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
        "name": menuname,
        "buyer_tel": buyerTel,
        "buyer_email": buyerEmail,
        "buyer_name": buyerName,
        "amount": amount,
        "custom_data": customData?.toJson(),
      };
}

class DeliveryInfo {
  final String memo, paymenttype, packagingMethod, size, tempture;
  final bool take;

  const DeliveryInfo(
    this.memo,
    this.paymenttype,
    this.take,
    this.packagingMethod,
    this.tempture,
    this.size,
  );

  DeliveryInfo.fromJson(Map<String, dynamic> json)
      : memo = json['memo'] ?? "",
        take = json['take'],
        paymenttype = json['paymenttype'] ?? "card",
        size = json['size'],
        tempture = json['tempture'] ?? "HOT",
        packagingMethod = json['packagingMethod'];

  Map<String, dynamic> toJson() => {
        "memo": memo,
        "take": take,
        "paymenttype": paymenttype,
        "size": size,
        "tempture": tempture,
        "packagingMethod": packagingMethod,
      };
}

class MenuModel {
  late String name, en_name, thumbnail;
  late int detailId;
  late MenuCategory category;
  int count = 1;

  MenuModel(
    this.category,
    this.count,
    this.name,
    this.en_name,
    this.thumbnail,
    this.detailId,
  );

  MenuModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    en_name = json['en_name'];
    thumbnail = json['thumbnail'];
    category = convertCategory(json['category']);
    detailId = json['detailId'];
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "category": category.name,
        "en_name": en_name,
        "thumbnail": thumbnail,
        "detailId": detailId,
        "count": count,
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

  setMenuName(String newName) => name = newName;
}

class MenuDetailModel {
  String? description;
  late final List<dynamic> allergys, nutritions;
  late final int price;

  MenuDetailModel(
    this.description,
    this.allergys,
    this.nutritions,
    this.price,
  );

  MenuDetailModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    allergys = [];
    nutritions = [];
    price = json['price'];

    if (json['allergys'] != null) {
      for (var allergy in json['allergys']) {
        allergys.add(allergy);
      }
    }

    if (json['nutritions'] != null) {
      for (var nutrition in json['nutritions']) {
        nutritions.add(nutrition);
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
      caffeine,
      volume;

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
    this.volume,
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
        saturatedfat = json['saturatedfat'],
        volume = json['volume'];

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
        "volume": volume,
      };
}

const List<String> nutritionCategorys = [
  "calorie",
  "carbohydrate",
  "sugars",
  "salt",
  "protein",
  "fat",
  "cholesterol",
  "transfat",
  "saturatedfat",
  "caffeine",
];

const List<String> nutritionKRCategorys = [
  "칼로리",
  "탄수화물",
  "설탕",
  "소금",
  "단백질",
  "지방",
  "콜레스테롤",
  "트랜스지방",
  "포화지방",
  "카페인",
];
