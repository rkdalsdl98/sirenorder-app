import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/datasource/local_manager.dart';

class UserRepository extends Equatable {
  final LocalManager _localManager;
  const UserRepository(this._localManager);

  /// 토큰의 데이터 타입: { "accesstoken": string }
  Future<Map<String, dynamic>?> getToken() async {
    return await _localManager.getJsonData("token");
  }

  Future<bool> saveData(String key, Map<String, dynamic>? data) async {
    return await _localManager.saveDataFromJson(key, {...?data});
  }

  Future<bool> deleteData(String key) async {
    return await _localManager.deleteData(key);
  }

  @override
  List<Object?> get props => [_localManager];
}
