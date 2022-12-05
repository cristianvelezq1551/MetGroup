part of '../details_screen.dart';

class _CreateArticle extends StatefulWidget {
  const _CreateArticle({super.key, required this.store, this.onCreate});

  final StoreModel store;
  final Function(ItemModel)? onCreate;

  @override
  State<_CreateArticle> createState() => _CreateArticleState();
}

class _CreateArticleState extends State<_CreateArticle> {
  /// The form key
  final _formKey = GlobalKey<FormState>();

  /// The article name
  final _nameController = TextEditingController();

  /// The price name
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear artículo'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GeneralInput(
              controller: _nameController,
              label: 'Nombre del articulo',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            GeneralInput(
              controller: _priceController,
              label: 'Precio del articulo',
              validator: ((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Ingrese un precio';
                }

                ///If the price is not a number, return an error
                if (double.tryParse(p0) == null) {
                  return 'Ingrese un precio válido';
                }

                return null;
              }),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancelar'),
        ),
        Consumer(builder: (context, ref, _) {
          /// If the store is loading, show the loading icon
          final isLoading =
              ref.watch(detailsControllerProvider) is DetailsLoadingState;

          return TextButton(
            onPressed: () {
              ///If the form is valid, create the article
              if (_formKey.currentState!.validate()) {
                ///Create the article
                ref.read(detailsControllerProvider.notifier).createArticle(
                      name: _nameController.text,
                      price: double.parse(_priceController.text),
                      storeId: widget.store.id,
                      onCreate: widget.onCreate,
                    );
              }
            },
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text('Crear artículo'),
          );
        }),
      ],
    );
  }
}
