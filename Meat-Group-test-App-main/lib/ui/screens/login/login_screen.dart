import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/app/routes/routes.dart';
import 'package:meat_group/ui/widgets/buttons/General_button.dart';
import 'package:meat_group/ui/widgets/dialogs/general_dialog.dart';
import 'package:meat_group/ui/widgets/inputs/general_input.dart';

import '../../views/dialogs/error.dart';
import '../../widgets/inputs/password_input.dart';
import 'login_controller.dart';
import 'login_states.dart';

///Widgets
part 'widgets/form.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///?Listen to the state of the login screen for dialog and alert.
    ref.listen(loginControllerProvider, (previous, next) {
      ///If the state is an error state.
      if (next is LoginErrorState) {
        uiErrorDialog(context, 'Credenciales incorrectas');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: const _Form(),
    );
  }
}
