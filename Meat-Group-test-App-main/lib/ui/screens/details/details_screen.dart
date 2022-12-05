import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/ui/screens/details/details_controller.dart';
import 'package:meat_group/ui/widgets/inputs/general_input.dart';

import '../../../data/models/store_model.dart';
import '../../widgets/dialogs/general_dialog.dart';
import 'details_state.dart';

///Widgets
part 'widgets/item_article.dart';

///Dialogs
part 'dialogs/create.dart';
part 'dialogs/delete.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({
    super.key,
    required this.store,
    required this.onCreate,
    required this.onDelete,
    required this.onUpdate,
  });

  final StoreModel store;
  final Function(ItemModel)? onCreate;
  final Function(ItemModel)? onDelete;
  final Function(ItemModel)? onUpdate;

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  late List<ItemModel> items;

  @override
  void initState() {
    items = widget.store.items ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Alerts and dialogs are displayed using the context of the scaffold.
    ref.listen(detailsControllerProvider, (previous, next) {
      ///If the state is an error state
      if (next is DetailsErrorState) {
        AppDialogs.uiErrorDialog(context,
            message: 'Algo salió mal, intente de nuevo más tarde');
      }

      ///If the state is a success state
      if (next is DetailsSuccessState) {
        Navigator.of(context).maybePop();
      }
    });

    log('REBUILD');

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.store.name}'),
        actions: [
          ///Add article
          IconButton(
            tooltip: 'Agregar artículo',
            icon: const Icon(Icons.add_circle_outline_rounded),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => _CreateArticle(
                  store: widget.store,

                  ///Add the item to the store
                  onCreate: (item) =>
                      setState(() => widget.onCreate?.call(item)),
                ),
              );
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          ///If the store has no articles
          if (items.isEmpty) {
            return const Center(child: Text('No hay artículos'));
          }

          return ListView(
            children: List.generate(
              items.length,
              (index) {
                final item = items[index];

                return _ItemArticle(
                  article: item,

                  ///Delete article from the store
                  onDelete: (item) =>
                      setState(() => widget.onDelete?.call(item)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
