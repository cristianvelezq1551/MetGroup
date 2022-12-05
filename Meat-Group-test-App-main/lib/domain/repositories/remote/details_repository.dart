import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/data/models/store_model.dart';

import '../../../data/services/remote/details_services.dart';

class DetailsRepository {
  ///Data source
  final DetailsServices _detailsServices;

  DetailsRepository(this._detailsServices);

  ///Create article
  Future<ItemModel> createArticle({
    required int? storeId,
    required String name,
    required double price,
  }) =>
      _detailsServices.createArticle(
        storeId: storeId,
        name: name,
        price: price,
      );

  ///Update article
  Future<ItemModel> updateArticle({
    required String? storeId,
    required String name,
    required double price,
  }) =>
      _detailsServices.updateArticle(
        storeId: storeId,
        name: name,
        price: price,
      );

  ///Delete article
  Future<void> deleteArticle({required String? name}) =>
      _detailsServices.deleteArticle(name: name);
}

final detailsRepositoryProvider =
    Provider.autoDispose<DetailsRepository>((ref) {
  return DetailsRepository(ref.read(detailsServicesProvider));
});
