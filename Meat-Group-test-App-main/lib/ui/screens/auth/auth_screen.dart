import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/ui/screens/login/login_screen.dart';

import '../../views/error.dart';
import '../../views/loading.dart';
import '../stores/stores_screen.dart';
import 'auth_controller.dart';
import 'auth_states.dart';

///?The screen to be displayed according to the state of the authentication screen.
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ///?TODO: LISTEN TO BACK NAVIGATION

    return Consumer(builder: ((context, ref, child) {
      ///This reference is the same as the reference in the compile method,
      ///to render the view inside the consumer widget with the watch method.
      final state = ref.watch(authControllerProvider);

      ///The loading screen.
      if (state is AuthLoadingState) {
        return const LoadingView();
      }

      ///The error screen.
      if (state is AuthErrorState) {
        return ErrorView(message: state.message);
      }

      ///The authenticated screen.
      if (state is AuthLoggedInState) {
        return const StoresScreen();
      }

      ///The login screen.
      return const LoginScreen();
    }));
  }
}
