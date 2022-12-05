import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/data/models/store_model.dart';

import '../../../app/constants/resource.dart';

class DetailsServices {
  ///The connection to the API.
  final _dio = Dio(
    BaseOptions(
      baseUrl: Resource.API_ENDPOINT,
      contentType: 'application/json',
    ),
  );

  ///Create article
  Future<ItemModel> createArticle(
      {required int? storeId,
      required String name,
      required double price}) async {
    ///Call the API for create article
    final response = await _dio.post(
      '/item/$name',
      data: {
        'store_id': storeId,
        'price': price,
      },
    );

    ///Print the response of the API.
    log(response.data.toString());

    return ItemModel.fromJson(response.data);
  }

  ///Update article
  Future<ItemModel> updateArticle({
    required String? storeId,
    required String name,
    required double price,
  }) async {
    ///Call the API for update article
    final response = await _dio.put(
      '/item/$name',
      data: {
        'store_id': storeId,
        'price': price,
      },
    );

    ///Print the response of the API.
    log(response.data.toString());

    return ItemModel.fromJson(response.data);
  }

  ///Delete article
  Future<void> deleteArticle({required String? name}) async {
    ///Call the API for delete article
    final response = await _dio.delete('/item/$name');

    ///Print the response of the API.
    log(response.data.toString());
  }
}

final detailsServicesProvider =
    Provider.autoDispose<DetailsServices>((ref) => DetailsServices());
