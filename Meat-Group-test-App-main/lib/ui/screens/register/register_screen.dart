import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/ui/screens/register/register_controller.dart';
import 'package:meat_group/ui/screens/register/register_state.dart';
import 'package:meat_group/ui/widgets/dialogs/general_dialog.dart';
import 'package:meat_group/ui/widgets/inputs/general_input.dart';
import 'package:meat_group/ui/widgets/inputs/password_input.dart';

import '../../widgets/buttons/general_button.dart';

///Widgets
part 'widgets/form.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///?Listen to the state of the register screen for dialog and alert.
    ///?When the user is registered, the state is a [RegisterSuccessState] and navigates to the login screen.
    ///?When the state is an error state, the state is a [RegisterErrorState] and shows an error dialog.
    ref.listen(registerControllerProvider, (previous, next) {
      ///If the state is a success state.
      if (next is RegisterErrorState) {
        AppDialogs.uiErrorDialog(context,
            message: 'Algo salió mal, intente de nuevo más tarde');
      }

      ///If the state is an error state.
      if (next is RegisterSuccessState) {
        ///Remove focus from the current focus node.
        FocusScope.of(context).unfocus();

        ///Navigate to the login screen.
        Navigator.pop(context, true);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta nueva'),
      ),
      body: const _Form(),
    );
  }
}
