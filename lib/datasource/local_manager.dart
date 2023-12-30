import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class LocalManager {
  Future<Map<String, dynamic>?> getJsonData(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final data = storage.getString(key);
    if (data == null) {
      return null;
    }
    return jsonDecode(data);
  }

  Future<List<Map<String, dynamic>>?> getJsonListData(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final list = storage.getStringList(key);
    if (list == null) {
      return null;
    }
    return stringListToJsonList(list);
  }

  Future<bool> saveDataFromJsonList(
      String key, List<Map<String, dynamic>> list) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return await storage
        .setStringList(key, jsonListToStringList(list))
        .catchError((err) => throw BlocException(
              "알 수 없는 오류가 발생했습니다.",
              ExceptionType.UnknownException,
            ));
  }

  Future<bool> saveDataFromJson(String key, Map<String, dynamic> json) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return await storage
        .setString(key, jsonEncode(json))
        .catchError((err) => throw BlocException(
              "알 수 없는 오류가 발생했습니다.",
              ExceptionType.UnknownException,
            ));
  }

  Future<bool> deleteData(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return await storage.remove(key).catchError((err) {
      throw BlocException(
        "알 수 없는 오류가 발생했습니다.",
        ExceptionType.UnknownException,
      );
    });
  }

  List<String> jsonListToStringList(List<Map<String, dynamic>> list) {
    return list.map<String>((json) => jsonEncode(json)).toList();
  }

  List<Map<String, dynamic>> stringListToJsonList(List<String> list) {
    return list
        .map<Map<String, dynamic>>(
            (str) => jsonDecode(str) as Map<String, dynamic>)
        .toList();
  }
}
