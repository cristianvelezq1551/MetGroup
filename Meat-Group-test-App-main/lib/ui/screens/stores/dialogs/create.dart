part of '../stores_screen.dart';

class _CreateStore extends ConsumerStatefulWidget {
  const _CreateStore({super.key});

  @override
  ConsumerState<_CreateStore> createState() => _CreateStoreState();
}

class _CreateStoreState extends ConsumerState<_CreateStore> {
  ///Form key
  final _formKey = GlobalKey<FormState>();

  ///Store name
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Crear tienda'),
        content: Form(
          key: _formKey,
          child: GeneralInput(
            controller: _nameController,
            label: 'Nombre de la tienda',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El nombre de la tienda no puede estar vacío';
              }
              return null;
            },
          ),
        ),
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .read(storesControllerProvider.notifier)
                              .createStore(name: _nameController.text);
                        }
                      },
                      child: const Text('Crear'),
                    );
            },
          ),
        ],
      ),
    );
  }
}
