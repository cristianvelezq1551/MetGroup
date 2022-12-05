import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meat_group/data/services/remote/login_services.dart';

import '../../../data/models/user_model.dart';
import '../../../domain/repositories/local/auth_repository.dart';
import '../auth/auth_controller.dart';
import '../auth/auth_states.dart';
import 'login_states.dart';

class LoginController extends StateNotifier<LoginStates> {
  LoginController(this._authController, this._loginServices)
      : super(LoginInitialStates());

  final AuthController _authController;
  final LoginServices _loginServices;

  ///change the state
  void changeState(LoginStates state) => this.state = state;

  ///?Get state
  LoginStates get getState => state;

  ///Sign in with email and password.
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    changeState(LoginLoadingState());

    try {
      final token = await _loginServices.signInWithEmailAndPassword(
          email: email, password: password);

      final user = UserModel(
        username: email,
        accessToken: token,
      );

      await _authController.saveUser(user);
      _authController.changeState(AuthLoggedInState(user: user));
    } catch (e) {
      changeState(LoginErrorState(message: e.toString()));
    }
  }

  @override
  void dispose() {
    log('LoginController dispose');
    super.dispose();
  }
}

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginStates>(
  (ref) => LoginController(
    ref.read(authControllerProvider.notifier),
    ref.read(loginServicesProvider),
  ),
);
