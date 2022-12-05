import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/ui/screens/auth/auth_controller.dart';
import 'package:meat_group/ui/screens/stores/stores_controller.dart';
import 'package:meat_group/ui/widgets/buttons/general_button.dart';
import 'package:meat_group/ui/widgets/dialogs/general_dialog.dart';
import 'package:meat_group/ui/widgets/inputs/general_input.dart';

import '../../../app/routes/routes.dart';
import '../../../data/models/store_model.dart';
import 'stores_state.dart';

///Widgets
part 'widgets/item_store.dart';

///Dialogs
part 'dialogs/delete.dart';
part 'dialogs/create.dart';

class StoresScreen extends ConsumerStatefulWidget {
  const StoresScreen({super.key});

  @override
  ConsumerState<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends ConsumerState<StoresScreen> {
  @override
  Widget build(BuildContext context) {
    ///Alerts and dialogs are displayed using the context of the scaffold.
    ref.listen(storesControllerProvider, (pre, next) {
      ///If the state is an error state
      if (next.state is StoresErrorEventState) {
        AppDialogs.uiErrorDialog(context,
            message: 'Algo salió mal, intente de nuevo más tarde');
      }

      ///If the state is a success state
      if (next.state is StoresSuccessEventState) {
        Navigator.of(context).maybePop();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tiendas'),
        actions: [
          ///Add store
          IconButton(
            tooltip: 'Agregar tienda',
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const _CreateStore(),
            ),
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),

          ///Refresh all store
          IconButton(
              tooltip: 'Refrescar',
              onPressed: ref.read(storesControllerProvider.notifier).getStores,
              icon: const Icon(Icons.refresh_rounded)),

          ///Sign out
          IconButton(
            tooltip: 'Salir',
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ///The stores state
          final state = ref
              .watch(storesControllerProvider.select((value) => value.state));

          ///The stores
          final stores = ref
              .watch(storesControllerProvider.select((value) => value.stores));

          ///If loading.
          if (state is StoresLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          ///If there is an error when getting the stores.
          if (state is StoresErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Revisa tu conexión a internet',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  GeneralButton(
                    text: 'Reintentar',
                    onPressed:
                        ref.read(storesControllerProvider.notifier).getStores,
                  )
                ],
              ),
            );
          }

          //If the stores is empty.
          if (stores.isEmpty) {
            return const Center(child: Text('No hay tiendas registradas'));
          }

          ///Show the stores.
          return ListView(
            children: List.generate(stores.length, (index) {
              final store = stores[index];

              return _ItemStore(
                store: store,
                onCreateItem: (item) => setState(() => store.items?.add(item)),
                onUpdateItem: (item) {},
                onDeleteItem: (item) {
                  final index = store.items
                      ?.indexWhere((element) => element.id == item.id);

                  ///Remove item from the list
                  setState(() {
                    if (index != null && index >= 0) {
                      store.items?.removeAt(index);
                    }
                  });
                },
              );
            }),
          );
        },
      ),
    );
  }
}
