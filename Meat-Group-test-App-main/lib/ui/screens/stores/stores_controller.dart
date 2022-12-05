import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/data/models/store_model.dart';
import 'package:meat_group/domain/repositories/remote/store_repository.dart';

import 'stores_state.dart';

class StoresController extends ChangeNotifier {
  StoresController(this._storeRepository) {
    getStores();
  }

  ///Repository of the stores.
  final StoreRepository _storeRepository;

  List<StoreModel> stores = [];

  StoresStates state = StoresInitialState();

  ///Change the state.
  void changeState(StoresStates newState) {
    state = newState;
    notifyListeners();
  }

  ///Add store to the list.
  void addItem({required ItemModel item, required int? storeId}) {
    stores.firstWhere((element) => element.id == storeId).items?.add(item);
    notifyListeners();
  }

  ///Remove store from the list.
  void removeItem({required ItemModel item, required int? storeId}) {
    stores.firstWhere((element) => element.id == storeId).items?.remove(item);
    notifyListeners();
  }

  /// Get all stores
  Future<void> getStores() async {
    changeState(StoresLoadingState());

    try {
      ///Get the stores.
      stores = await _storeRepository.getStores();

      ///Change the state.
      changeState(StoresSuccessState());
    } catch (e) {
      changeState(StoresErrorState(message: e.toString()));
    }
  }

  /// Create a store
  Future<void> createStore({required String name}) async {
    ///Change the state to loading.
    changeState(StoresLoadingEventState());

    try {
      ///Create the store.
      final store = await _storeRepository.createStore(name: name);

      ///Add the store to the list.
      stores.add(store);

      ///Change the state to success.
      changeState(StoresSuccessEventState());
    } catch (e) {
      ///Change the state to error.
      changeState(StoresErrorEventState(message: e.toString()));
    }
  }

  /// Delete store by name
  Future<void> deleteStoreByName({required String? name}) async {
    ///Change the state to loading.
    changeState(StoresLoadingEventState());

    try {
      ///Delete the store.
      await _storeRepository.deleteStoreByName(name: name);

      ///Remove the store from the list.
      stores.removeWhere((element) => element.name == name);

      ///Change the state to success.
      changeState(StoresSuccessEventState());
    } catch (e) {
      ///Change the state to error.
      changeState(StoresErrorEventState(message: e.toString()));
    }
  }

  @override
  void dispose() {
    log('Dispose StoresController');
    super.dispose();
  }
}

final storesControllerProvider = ChangeNotifierProvider.autoDispose(
  (ref) => StoresController(
    ref.read(storeRepositoryProvider),
  ),
);
