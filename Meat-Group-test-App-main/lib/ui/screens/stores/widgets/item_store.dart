part of '../stores_screen.dart';

class _ItemStore extends StatelessWidget {
  const _ItemStore(
      {super.key,
      required this.store,
      required this.onCreateItem,
      required this.onUpdateItem,
      required this.onDeleteItem});

  final StoreModel store;
  final Function(ItemModel)? onCreateItem;
  final Function(ItemModel)? onUpdateItem;
  final Function(ItemModel)? onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.storefront_outlined),
      title: Text(store.name ?? 'Unknown'),
      subtitle: Text('ID: ${store.id} - Items: ${store.items?.length}'),
      trailing: IconButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => _DeleteStores(store: store),
        ),
        icon: const Icon(
          Icons.delete_outline,
          color: Colors.red,
        ),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.details,
        arguments: {
          "store": store,
          "onCreate": onCreateItem,
          "onUpdate": onUpdateItem,
          "onDelete": onDeleteItem,
        },
      ),
    );
  }
}
