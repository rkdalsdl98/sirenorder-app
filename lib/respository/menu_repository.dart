import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/datasource/local_manager.dart';

class MenuRepository extends Equatable {
  final LocalManager _localManager;
  const MenuRepository(this._localManager);

  Future<bool> saveData(String key, Map<String, dynamic>? data) async {
    return await _localManager.saveDataFromJson(key, {...?data});
  }

  Future<bool> deleteData(String key) async {
    return await _localManager.deleteData(key);
  }

  @override
  List<Object?> get props => [_localManager];
}
