part of '../details_screen.dart';

class _DeleteArticle extends ConsumerWidget {
  const _DeleteArticle({super.key, required this.article, this.onDelete});

  final ItemModel article;
  final Function(ItemModel)? onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        final isLoading =
            ref.read(detailsControllerProvider) is DetailsLoadingState;

        ///If the state is loading, the dialog will not be closed.
        if (isLoading) {
          return false;
        }
        return true;
      },
      child: AlertDialog(
        title: const Text('Eliminar artículo'),
        content: Text(
            '¿Está seguro que desea eliminar el artículo ${article.name}?'),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Cancelar'),
          ),
          Consumer(builder: (context, ref, _) {
            final isLoading =
                ref.watch(detailsControllerProvider) is DetailsLoadingState;

            return isLoading
                ? const CircularProgressIndicator()
                : TextButton(
                    onPressed: () {
                      ref
                          .read(detailsControllerProvider.notifier)
                          .deleteArticle(item: article, onDelete: onDelete);
                    },
                    child: const Text('Eliminar'),
                  );
          }),
        ],
      ),
    );
  }
}
