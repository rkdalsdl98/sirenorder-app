import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/datasource/local_manager.dart';

class BasketRepository extends Equatable {
  final LocalManager _localManager;
  const BasketRepository(this._localManager);

  Future<bool> saveData(String key, Map<String, dynamic>? data) async {
    return await _localManager.saveDataFromJson(key, {...?data});
  }

  Future<bool> deleteData(String key) async {
    return await _localManager.deleteData(key);
  }

  Future<bool> saveBasket(List<Map<String, dynamic>>? data) async {
    return await _localManager.saveDataFromJsonList("basket", data ?? []);
  }

  Future<bool> clearBasket() async {
    return await _localManager.deleteData("basket");
  }

  Future<List<Map<String, dynamic>>?> getBasketItems() async {
    return await _localManager.getJsonListData("basket");
  }

  @override
  List<Object?> get props => [_localManager];
}
