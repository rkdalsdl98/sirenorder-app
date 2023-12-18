import 'package:equatable/equatable.dart';
import 'package:sirenorder_app/model/store_model.dart';
import 'package:sirenorder_app/type/bloc/bloc_error_type.dart';

abstract class StoreBlocState extends Equatable {
  final List<StoreModel> stores;
  StoreModel? selStore;
  StoreDetailModel? storeDetail;
  StoreBlocState(this.stores, this.storeDetail, this.selStore);
}

class StoreBlocInitState extends StoreBlocState {
  StoreBlocInitState() : super([], null, null);
  @override
  List<Object?> get props => [];
}

class StoreBlocLoadingState extends StoreBlocState {
  StoreBlocLoadingState(super.stores, super.storeDetail, super.selStore);
  @override
  List<Object?> get props => [];
}

class StoreBlocLoadedState extends StoreBlocState {
  StoreBlocLoadedState(super.stores, super.storeDetail, super.selStore);
  @override
  List<Object?> get props => [];
}

class StoreBlocShowDetailState extends StoreBlocState {
  StoreBlocShowDetailState(super.stores, super.storeDetail, super.selStore);
  @override
  List<Object?> get props => [];
}

class StoreBlocErrorState extends StoreBlocState {
  final BlocException exception;
  StoreBlocErrorState(
      super.stores, super.storeDetail, super.selStore, this.exception);
  @override
  // TODO: implement props
  List<Object?> get props => [exception];
}
