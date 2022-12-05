import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/data/models/store_model.dart';

import '../../../app/constants/resource.dart';

class StoreServices {
  ///The connection to the API.
  final _dio = Dio(
    BaseOptions(
      baseUrl: Resource.API_ENDPOINT,
      contentType: 'application/json',
    ),
  );

  ///Create a store.
  Future<StoreModel> createStore({required String name}) async {
    ///Call the API for create a store.
    final response = await _dio.post('/store/$name');

    ///Return the store created.
    return StoreModel.fromJson(response.data);
  }

  ///Get store by name.
  Future<StoreModel> getStoreByName({required String name}) async {
    ///Call the API for get store by id.
    final response = await _dio.get('/store/$name');

    ///Return the store.
    return StoreModel.fromJson(response.data);
  }

  ///Delete store by id.
  Future<void> deleteStoreByName({required String? name}) async {
    ///Call the API for delete store by id.
    final response = await _dio.delete('/store/$name');
  }

  ///Get the stores.
  Future<List<StoreModel>> getStores() async {
    ///Call the API for get the stores.
    final response = await _dio.get('/stores');

    ///Return the stores.
    return (response.data['stores'] as List)
        .map((e) => StoreModel.fromJson(e))
        .toList();
  }
}

final storeServicesProvider =
    Provider.autoDispose<StoreServices>((ref) => StoreServices());
