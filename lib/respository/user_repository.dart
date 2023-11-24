import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/datasource/local_manager.dart';

class UserRepository extends Equatable {
  final LocalManager _localManager;
  const UserRepository(this._localManager);

  @override
  List<Object?> get props => [_localManager];
}
