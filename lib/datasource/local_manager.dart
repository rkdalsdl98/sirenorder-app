import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

class LocalManager {
  SharedPreferences? _storage;
  LocalManager() {
    SharedPreferences.getInstance().then((storage) => _storage = storage);
  }

  Future<bool> saveDataFromJson(String key, Map<String, dynamic> json) async {
    if (_storage == null) {
      throw BlocException(
        "로컬 저장소 초기화에 실패했습니다.",
        ExceptionType.RepsitoryLoadException,
      );
    }
    return await _storage!
        .setString(key, jsonEncode(json))
        .catchError((err) => throw BlocException(
              "알 수 없는 오류가 발생했습니다.",
              ExceptionType.UnknownException,
            ));
  }

  Future<bool> deleteData(String key) async {
    if (_storage == null) {
      throw BlocException(
        "로컬 저장소 초기화에 실패했습니다.",
        ExceptionType.RepsitoryLoadException,
      );
    }
    return await _storage!.remove(key).catchError((err) => throw BlocException(
          "알 수 없는 오류가 발생했습니다.",
          ExceptionType.UnknownException,
        ));
  }
}
