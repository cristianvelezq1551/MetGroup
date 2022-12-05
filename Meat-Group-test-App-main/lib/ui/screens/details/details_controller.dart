import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/data/models/store_model.dart';
import 'package:meat_group/domain/repositories/remote/details_repository.dart';

import 'details_state.dart';

class DetailsController extends StateNotifier<DetailsStates> {
  DetailsController(this._detailsRepository) : super(DetailsInitialState());

  ///Repository of the stores details.
  final DetailsRepository _detailsRepository;

  ///Change the state
  void changeState(DetailsStates state) => this.state = state;

  ///Create article
  void createArticle({
    required int? storeId,
    required String name,
    required double price,
    Function(ItemModel)? onCreate,
  }) async {
    ///Change the state to loading.
    changeState(DetailsLoadingState());

    try {
      ///Create the article.
      final item = await _detailsRepository.createArticle(
        storeId: storeId,
        name: name,
        price: price,
      );

      ///Add the article to the list.
      onCreate?.call(item);

      ///Change the state to success.
      changeState(DetailsSuccessState());
    } catch (e) {
      log(e.toString());

      ///Change the state to error.
      changeState(DetailsErrorState(message: e.toString()));
    }
  }

  ///Update article
  void updateArticle(
      {required String? storeId,
      required String name,
      required double price,
      Function(ItemModel)? onUpdate}) async {
    ///Change the state to loading.
    changeState(DetailsLoadingState());

    try {
      ///Update the article.
      final item = await _detailsRepository.updateArticle(
        storeId: storeId,
        name: name,
        price: price,
      );

      ///Update the article in the list.
      onUpdate?.call(item);

      ///Change the state to success.
      changeState(DetailsSuccessState());
    } catch (e) {
      log(e.toString());

      ///Change the state to error.
      changeState(DetailsErrorState(message: e.toString()));
    }
  }

  ///Delete article
  void deleteArticle(
      {Function(ItemModel)? onDelete, required ItemModel item}) async {
    ///Change the state to loading.
    changeState(DetailsLoadingState());

    try {
      ///Delete the article.
      await _detailsRepository.deleteArticle(name: item.name);

      ///Delete the article in the list.
      onDelete?.call(item);

      ///Change the state to success.
      changeState(DetailsSuccessState());
    } catch (e) {
      log(e.toString());

      ///Change the state to error.
      changeState(DetailsErrorState(message: e.toString()));
    }
  }

  @override
  void dispose() {
    log('DetailsController dispose');
    super.dispose();
  }
}

final detailsControllerProvider =
    StateNotifierProvider.autoDispose<DetailsController, DetailsStates>(
  (ref) => DetailsController(
    ref.read(detailsRepositoryProvider),
  ),
);
