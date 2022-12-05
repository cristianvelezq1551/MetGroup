import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/data/models/store_model.dart';
import 'package:meat_group/data/services/remote/store_services.dart';

class StoreRepository {
  ///Data source
  final StoreServices _storeServices;

  StoreRepository(this._storeServices);

  ///Create a store.
  Future<StoreModel> createStore({required String name}) =>
      _storeServices.createStore(name: name);

  ///Get store by name.
  Future<StoreModel> getStoreByName({required String name}) =>
      _storeServices.getStoreByName(name: name);

  ///Delete store by id.
  Future<void> deleteStoreByName({required String? name}) =>
      _storeServices.deleteStoreByName(name: name);

  ///Get the stores.
  Future<List<StoreModel>> getStores() => _storeServices.getStores();
}

final storeRepositoryProvider = Provider.autoDispose<StoreRepository>(
  (ref) => StoreRepository(
    ref.read(storeServicesProvider),
  ),
);
