part of '../stores_screen.dart';

class _DeleteStores extends ConsumerWidget {
  const _DeleteStores({super.key, required this.store});

  final StoreModel store;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        final state = ref.read(storesControllerProvider).state;

        ///If the store is loading, don't close the dialog
        if (state is StoresLoadingEventState) {
          return false;
        }

        return true;
      },
      child: AlertDialog(
        title: const Text('Eliminar tienda'),
        content: Text('¿Está seguro de eliminar la tienda ${store.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          Consumer(
            builder: (context, ref, _) {
              ///If the store is loading, show the loading icon
              final isLoading = ref.watch(
                      storesControllerProvider.select((value) => value.state))
                  is StoresLoadingEventState;

              return isLoading
                  ? const CircularProgressIndicator()
                  : TextButton(
                      onPressed: () => ref
                          .read(storesControllerProvider.notifier)
                          .deleteStoreByName(name: store.name),
                      child: const Text('Eliminar'),
                    );
            },
          ),
        ],
      ),
    );
  }
}
